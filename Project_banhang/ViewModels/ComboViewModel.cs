using Project_banhang.Models.mModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Project_banhang.ViewModels
{
    public class ComboViewModel
    {
        public Combo combo { get; set; }
        public List<Product> productList { get; set; }
    }
}