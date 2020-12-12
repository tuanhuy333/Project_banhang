using Project_banhang.Models.mModel;
using Project_banhang.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Project_banhang.Controllers
{
    public class ProductController : Controller
    {
        BanHangContext _context = new BanHangContext();


            // GET: Product
        public ActionResult Index()
        {
            ProductViewmodel model = new ProductViewmodel();
            model.products = _context.Products.ToList();
            return View(model);
        }



    }
}