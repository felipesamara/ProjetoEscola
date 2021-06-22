using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using ProjetoEscola.Controllers.Helper;
using ProjetoEscola.Models;

namespace ProjetoEscola.Controllers
{
    public class tbAlunoController : HelperAluno
    {

        public ActionResult Index(int? id)
        {
            id = id != null ? id : Convert.ToInt32(Session["cdProfessor"]);
            var tbAlunoProfessor = db.tbAlunoProfessor.Include(t => t.tbProfessor).ToList();
            if (id != null)
            { 
                tbAlunoProfessor = tbAlunoProfessor.Where(x => x.cdProfessor == id).ToList();
                PegaNomeProfessor(id);
            }
            return View(tbAlunoProfessor.ToList());
        }

        public ActionResult TodosAlunos()
        {
            return View(db.tbAluno.ToList());
        }

        public ActionResult Create(int? id)
        {
            Session["cdProfessor"] = id;
            return View();
        }
       
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "cdAluno,nmAluno,valorMensalidade,vencimentoMensalidade")] tbAluno tbAluno)
        {         
            if (ModelState.IsValid)
            {
                db.tbAluno.Add(tbAluno);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(tbAluno);
        }
                  
        [HttpPost]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DeletarAluno(id);
            return Json(true, JsonRequestBehavior.AllowGet);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Upload(HttpPostedFileBase files)
        {

            string linhas;
            try
            {
                StreamReader reader = new StreamReader(files.InputStream);
                linhas = AdicionaAlunos(reader);
            }
            catch (Exception)
            {
                ModelState.AddModelError("ERRO", "ERRO AO SUBIR ARQUIVO");
                return View("Create");
            }
            int codigoProfessor = Convert.ToInt32(Session["cdProfessor"]);
            IList<tbAlunoProfessor> professores = db.tbAlunoProfessor.Where(x => x.cdProfessor == codigoProfessor).Include(x => x.tbProfessor).ToList(); 
            return RedirectToAction("Index", new { professores });
        }      
    }
}
