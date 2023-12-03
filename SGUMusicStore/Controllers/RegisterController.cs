using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using SGUMusicStore.Models;

namespace SGUMusicStore.Controllers
{
    public class RegisterController : Controller
    {
        private SGUMusicStoreEntities db = new SGUMusicStoreEntities();
        // GET: Register
        public ActionResult Index()
        {
            return View();
        }
        //POST:Register
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Index([Bind(Include = "idUser,idPermission,fullName,username,password,gender,identityCard,address,email,URLAvatar,phone")] User user)
        {

            if (ModelState.IsValid)
            {
                int count = db.Users.Count() + 1;
                user.idPermission = "P02";
                var id = 'U' + count.ToString();
                user.idUser = id;

                db.Users.Add(user);
                db.SaveChanges();
                return Redirect("~/Home");
            }
            else
            {
                ViewBag.idPermission = new SelectList(db.Permissions, "idPermission", "namePermission", user.idPermission);
                return View(user);
            }

        }
    }
}