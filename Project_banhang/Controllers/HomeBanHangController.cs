using Project_banhang.Models.mModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Project_banhang.Controllers
{
    public class HomeBanHangController : Controller
    {
        BanHangContext _context = new BanHangContext();


        // GET: HomeBanHang
        public ActionResult Index()
        {

            var data = (from c in _context.Comboes select c);
            return View(data.ToList());
        }
    }
}