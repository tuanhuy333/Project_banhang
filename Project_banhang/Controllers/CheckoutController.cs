using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Project_banhang.Models.mModel;
using Project_banhang.ViewModels;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace Project_banhang.Controllers
{
    public class CheckoutController : Controller
    {
        // GET: Checkout
        BanHangContext _context = new BanHangContext();

        public ActionResult Index()
        {
            CheckoutViewModel model = new CheckoutViewModel();             
            if(Session["username"] != null)
            {
                model.isLogin = 0;
            }
            else
            {
                //test logged in

                model.isLogin = 1;

            }
            return View(model);
        }
        public ActionResult checkout()
        {
            return RedirectToAction("Index","Checkout");
        }
        [HttpPost]
        public JsonResult checkSoLuong(String data)
        {
            String d= Request["data"];
            return Json(new { Success = true }, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult order(string fullname,string address,string phone,string cart)
        {
            JObject o = JObject.Parse(cart);
            var items = o["value"]["items"];
            StringBuilder message =new StringBuilder("");
            for (int i = 0; i < items.Count(); i++)
            {
                var obj = items[i];
                String id = (String)obj["add"];
                int sl = (int)obj["quantity"];
                if (id.StartsWith("c_"))
                {
                    //check so luong san pham trong combo


                }
                else
                {
                    int temp = Convert.ToInt32(id);
                    Product p = _context.Products.Where(m => m.ID == temp).FirstOrDefault();
                    if (p.Amount < sl)
                    {
                        message.Append(p.Product_Name + " chi con lai " + p.Amount + " san pham;");
                    }
                }
                

            }
            //neu san pham con hang thi luu hoa don
            if (message.ToString().Equals(""))
            {
                //luu hoa don
                Invoice invoice = new Invoice();
                invoice.ID = _context.Invoices.Count() + 1;
                List<InvoiceDetail> l_invoiceDetails = new List<InvoiceDetail>();
                int tongtien = 0;
                for (int i = 0; i < items.Count(); i++)
                {
                    var obj = items[i];
                    String id = (String)obj["add"];
                    int sl = (int)obj["quantity"];
                    int price = (int)obj["amount"];
                    InvoiceDetail invoiceDetail = new InvoiceDetail();
                    invoiceDetail.Amount = sl;
                    if (id.StartsWith("c_"))
                    {
                        invoiceDetail.Combo_ID = Convert.ToInt32(id.Split('_')[1]);
                        invoiceDetail.Product_ID = -1;
                    }
                    else
                    {
                        invoiceDetail.Product_ID = Convert.ToInt32(id);
                        invoiceDetail.Combo_ID = -1;
                    }
                    invoiceDetail.Price = price;
                    invoiceDetail.Invoice_ID = invoice.ID;
                    l_invoiceDetails.Add(invoiceDetail);
                    tongtien += price * sl;
                }
                invoice.customerAddress = address;
                invoice.Invoice_Name = "sell invoice";
                invoice.totalMoney = Convert.ToString(tongtien);
                invoice.status = 0;
                invoice.createdDate = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss").ToString();
                invoice.shipDate = DateTime.Now.AddDays(3).ToString("yyyy-MM-dd hh:mm:ss").ToString();
                //save invoice and save invoice detail set id invoice for invoice detail
                invoice.Customer_ID = Convert.ToInt32(Session["userid"]);
                invoice.ID = _context.Invoices.Count() + 1;

                // don hang
               
                _context.Invoices.Add(invoice);
                _context.SaveChanges();

                //chi tiet don hang
                //var id_chitiet = _context.InvoiceDetails.Count() + 1;
                l_invoiceDetails.ForEach(i => {
                    string strSQL = "INSERT INTO InvoiceDetail ";
                    strSQL += " (Invoice_ID,Product_ID,Combo_ID,Amount,Price)";
                    strSQL += " VALUES";
                    strSQL += " (@Invoice_ID,@Product_ID,@Combo_ID,@Amount,@Price)";
                    
                    List<SqlParameter> parameterList = new List<SqlParameter>();
                    parameterList.Add(new SqlParameter("@Invoice_ID", i.Invoice_ID));
                    parameterList.Add(new SqlParameter("@Product_ID", i.Product_ID));
                    parameterList.Add(new SqlParameter("@Combo_ID", i.Combo_ID));
                    parameterList.Add(new SqlParameter("@Amount", i.Amount));
                    parameterList.Add(new SqlParameter("@Price", i.Price));


                    SqlParameter[] Param = parameterList.ToArray();

                    int noOfRowInserted = _context.Database.ExecuteSqlCommand(strSQL, Param);
                });
               


                message.Append("order susscess");
                return Json(new { Success = true, message = message.ToString() }, JsonRequestBehavior.AllowGet);
            }

            /*"cmd": "_cart",
              "add": "1",
              "item_name": "Laptop Acer Aspire 3 A315 56 36YS i3 1005G1 (NX.HS5SV.008)-10",
              "amount": 3690000,
              "submit": "Add to cart",
              "quantity": 2,
              "href": "http://localhost:9316/product"
            */

            return Json(new { Success = false, message = message.ToString() }, JsonRequestBehavior.AllowGet);
        }
        public ActionResult orderSuccess()
        {
            return View();
        }
        public ActionResult product()
        {
            return RedirectToAction("Index","product");
        }
        public ActionResult Invoice()
        {
            var id = Convert.ToInt32(Session["userid"]);
            var invoice = (from p in _context.Invoices select p).Where(p => p.Customer_ID == id);

            return View(invoice.ToList());
        }
        public ActionResult Detail(int? id = 1)
        {
            var invoice = (from p in _context.Invoices select p).Where(p => p.ID == id);
            var details = (from p in _context.InvoiceDetails select p).Where(p => p.Invoice_ID == id).ToList();

            List<Product> proList = new List<Product>();
            List<Combo> comboList = new List<Combo>();
            foreach (var item in details)
            {
                // combo
                if(item.Product_ID == -1)
                {
                    var combo = (from p in _context.Comboes select p).Where(p => p.ID == item.Combo_ID).First();
                    comboList.Add(combo);

                }
                // sp 
                else if(item.Combo_ID == -1)
                {
                    var pro = (from p in _context.Products select p).Where(p => p.ID == item.Product_ID).First();
                    proList.Add(pro);
                }
               
            }

            InvoiceDetailViewModel model = new InvoiceDetailViewModel();
            model.createdDate = invoice.First().createdDate;
            model.productList = proList;
            model.comboList = comboList;

            return View(model);
        }



    }
}