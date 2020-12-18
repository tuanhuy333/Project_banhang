using Project_banhang.Models.mModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace Project_banhang.Controllers
{
    public class AccountController : Controller
    {
        BanHangContext _context = new BanHangContext();
        // GET: Account
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult ValidateUser(string userid, string password)
        {
            password = MD5Hash(password);
            var data1 = (from c in _context.Customers select c);

            var data = data1.AsEnumerable().Where(c => c.username == userid && c.password == password);
            Customer a = data.First<Customer>();
            if (data.Count() > 0)
            {
                // lưu vào Session
                Session["username"] = userid;
                Session["userid"] = a.ID;
                return Json(new { Success = true, type = a.gender}, JsonRequestBehavior.AllowGet);
            }


            else
                return Json(new { Success = false }, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public JsonResult register(string fullname, string username, string pass, string address, string phone)
        {
            Customer c = new Customer();
            c.username = username;
            c.firstName = fullname;
            c.lastName = fullname; 
            c.password = MD5Hash(pass);
            c.address = address;
            c.joinDate = "";
            c.isNew = true;
            c.gender = true;
            c.birthDate = "";
            c.ID = _context.Customers.Count() + 1;

            _context.Customers.Add(c);
            _context.SaveChanges();

            return Json(new { Success = false }, JsonRequestBehavior.AllowGet);

        }
        public ActionResult Logout()
        {
            Session.Remove("username");
            return RedirectToAction("index", "HomeBanHang", new { area = "" });
        }

        public String MD5Hash(String text)
        {
            MD5 md5 = new MD5CryptoServiceProvider();

            //compute hash from the bytes of text  
            md5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(text));

            byte[] result = md5.Hash;

            StringBuilder strBuilder = new StringBuilder();
            for (int i = 0; i < result.Length; i++)
            {
                strBuilder.Append(result[i].ToString("x2"));
            }

            return strBuilder.ToString();
        }
    }
}