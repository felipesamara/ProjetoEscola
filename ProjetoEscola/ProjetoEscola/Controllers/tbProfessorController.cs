using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using ProjetoEscola.Models;

namespace ProjetoEscola.Controllers
{
    public class tbProfessorController : Controller
    {
        private dbEscolaEntities db = new dbEscolaEntities();

        public ActionResult Index()
        {
            var tbProfessor = db.tbProfessor.Include(t => t.tbAlunoProfessor);
            return View(tbProfessor.ToList());
        }

        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbProfessor tbProfessor = db.tbProfessor.Find(id);
            if (tbProfessor == null)
            {
                return HttpNotFound();
            }
            return View(tbProfessor);
        }

        public ActionResult Create()
        {
            ViewBag.cdAluno = new SelectList(db.tbAluno, "cdAluno", "nmAluno");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "cdProfessor,nmProfessor,cdAluno,nmMateria")] tbProfessor tbProfessor)
        {
           
            if (ModelState.IsValid)
            {
                db.tbProfessor.Add(tbProfessor);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(tbProfessor);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
