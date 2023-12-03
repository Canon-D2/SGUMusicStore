using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using SGUMusicStore.Models;
using static SGUMusicStore.Models.Product;

namespace SGUMusicStore.Controllers
{
    public class CollectionsController : Controller
    {
        private SGUMusicStoreEntities db = new SGUMusicStoreEntities();

        // GET: Collections
        public ActionResult Index()
        {
            var query = db.Products.Include(p => p.ImageProducts);
            ViewBag.list = query.ToList();
            return View(query.ToList());

        }

        // GET: Collections/Details
  
        public ActionResult Details(string id)
        {
            ProductDTODetail productDTO = new ProductDTODetail();
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var product = from el in db.Products
                          where el.idProduct == id
                          select el;

            if (product == null)
            {
                return HttpNotFound();
            }
            else
            {

                var data = from p in product
                           select p;

                data.Include("ImageProducts").Include("Type");
                var datarelateto = (from p in db.Products
                                    join t in data on p.idType equals t.idType
                                    select p);
                datarelateto.Include("ImageProducts").Include("Type");
                var subData = (datarelateto.ToList()).Skip(3).Take(4);
                ViewBag.datarelateto = subData.ToList();
                ViewBag.List = data;
                return View(data.ToList());
            };
        }


        // collections/guitar
        public ActionResult guitar(string id)
        {
            id = "T01";
            var productList = (from s in db.Products
                               where s.idType == id
                               select s);

            var query = productList.Include(p => p.ImageProducts);
            ViewBag.list = query.ToList();
            return View(query.ToList());
        }

        // collections/violin
        public ActionResult violin(string id)
        {
            id = "T02";
            var productList = (from s in db.Products
                               where s.idType == id
                               select s);

            var query = productList.Include(p => p.ImageProducts);
            ViewBag.list = query.ToList();
            return View(query.ToList());
        }

        // collections/piano
        public ActionResult piano(string id)
        {
            id = "T03";
            var productList = (from s in db.Products
                               where s.idType == id
                               select s);

            var query = productList.Include(p => p.ImageProducts);
            ViewBag.list = query.ToList();
            return View(query.ToList());
        }

        // collections/organ
        public ActionResult organ(string id)
        {
            id = "T04";
            var productList = (from s in db.Products
                               where s.idType == id
                               select s);

            var query = productList.Include(p => p.ImageProducts);
            ViewBag.list = query.ToList();
            return View(query.ToList());
        }

        // collections/harmonica
        public ActionResult harmonica(string id)
        {
            id = "T05";
            var productList = (from s in db.Products
                               where s.idType == id
                               select s);

            var query = productList.Include(p => p.ImageProducts);
            ViewBag.list = query.ToList();
            return View(query.ToList());
        }

        // collections/drum
        public ActionResult drum(string id)
        {
            id = "T06";
            var productList = (from s in db.Products
                               where s.idType == id
                               select s);

            var query = productList.Include(p => p.ImageProducts);
            ViewBag.list = query.ToList();
            return View(query.ToList());
        }

        // collections/phukien
        public ActionResult phukien(string id)
        {
            id = "T07";
            var productList = (from s in db.Products
                               where s.idType == id
                               select s);

            var query = productList.Include(p => p.ImageProducts);
            ViewBag.list = query.ToList();
            return View(query.ToList());
        }
    }
}
