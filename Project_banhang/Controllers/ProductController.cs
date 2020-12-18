using PagedList;
using PagedList.Mvc;
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
        public ActionResult Index([Bind(Include = "ID")] Catalog catalog, string Search_Data, string Filter_Value, int? page)
        {

            // Tạo cbx
            // Lấy toàn bộ thể loại:
            List<Catalog> cate = _context.Catalogs.ToList();

            // Tạo SelectList
            SelectList List = new SelectList(cate, "ID", "Catalog_Name", 0);

            // Set vào ViewBag
            ViewBag.catalogList = List;

            // search
            if (Search_Data != null)
            {
                page = 1;
            }
            else
            {
                Search_Data = Filter_Value;
            }

            ViewBag.FilterValue = Search_Data;

            if (page == null) page = 1;

            // nếu id catalog = 0  thì show tất cả
            var data = catalog.ID == 0 ? (from l in _context.Products select l) : (from l in _context.Products select l).Where(m=>m.Catalog_ID == catalog.ID);


            if (!String.IsNullOrEmpty(Search_Data))
            {
                data = data.Where(stu => stu.Product_Name.Contains(Search_Data));
            }

            data = data.OrderBy(stu => stu.ID);

            // so sp trong trang
            int pageSize = 6;

          
            int pageNumber = (page ?? 1);

           
            return View(data.ToPagedList(pageNumber, pageSize));

           // ProductViewmodel model = new ProductViewmodel();
            //model.products = _context.Products.ToList();
            //return View(model);
        }


        public ActionResult Detail(int? idPro = 1)
        {
            var pro = (from p in _context.Products select p).Where(p => p.ID == idPro).First();
            var proDetail = (from p in _context.ProductDetails select p).Where(p => p.Product_ID == idPro).First();

            ProductViewmodel model = new ProductViewmodel();
            model.product = pro;
            model.productDetail = proDetail;

            return View(model);
        }



    }
    
}