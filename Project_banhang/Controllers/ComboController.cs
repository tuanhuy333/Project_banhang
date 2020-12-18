using Project_banhang.Models.mModel;
using Project_banhang.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Project_banhang.Controllers
{
    public class ComboController : Controller
    {
        BanHangContext _context = new BanHangContext();
        // GET: Combo
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Detail(int? idCombo = 1)
        {

            var data = (from c in _context.Comboes select c).Where(c => c.ID == idCombo).First();
            string s = data.Product_List.ToString();
            string[] idList = s.Split(';');

            List<Product> proList = new List<Product>();
            foreach(string item in idList){
                int idPro = int.Parse(item);
                var product = (from p in _context.Products select p).Where(p => p.ID == idPro).First();
                proList.Add(product);
            }
            ComboViewModel model = new ComboViewModel();
            model.combo = data ; 
            model.productList = proList;
           

            return View(model);
        }
    }
}