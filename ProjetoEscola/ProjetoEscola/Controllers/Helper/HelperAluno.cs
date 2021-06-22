using ProjetoEscola.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProjetoEscola.Controllers.Helper
{
    public class HelperAluno : Controller
    {
        //git
        public dbEscolaEntities db = new dbEscolaEntities();

        public string AdicionaAlunos(StreamReader reader)
        {
            string linhas;
            while ((linhas = reader.ReadLine()) != null)
            {
                string[] linha = linhas.ToString().Split('|');
                string mensal = linha[1].ToString().Trim();
                SalvarAluno(linha, mensal);
            }
            return linhas;
        }

        private void SalvarAluno(string[] linha, string mensal)
        {
            tbAluno novoAluno = new tbAluno();
            novoAluno.nmAluno = linha[0];
            novoAluno.valorMensalidade = Convert.ToDecimal(mensal);
            novoAluno.vencimentoMensalidade = Convert.ToDateTime(linha[2]);
            db.tbAluno.Add(novoAluno);
            db.SaveChanges();
            SalvarAlunoProfessor(novoAluno);
        }

        private void SalvarAlunoProfessor(tbAluno novoAluno)
        {
            tbAlunoProfessor alunoProfessor = new tbAlunoProfessor();
            tbProfessor prof = db.tbProfessor.Find(Session["cdProfessor"]);
            alunoProfessor.cdProfessor = prof.cdProfessor;
            alunoProfessor.cdAluno = novoAluno.cdAluno;
            db.tbAlunoProfessor.Add(alunoProfessor);
            db.SaveChanges();
        }

        public void DeletarAluno(int? id)
        {
            tbAluno tbAluno = db.tbAluno.Find(id);
            db.tbAluno.Remove(tbAluno);
            db.tbAlunoProfessor.RemoveRange(db.tbAlunoProfessor.Where(x => x.cdAluno == id));
            db.SaveChanges();
        }

        public void PegaNomeProfessor(int? id)
        {
            tbProfessor prof = db.tbProfessor.Find(id);
            ViewBag.nmProfessor = prof.nmProfessor;
        }
    }
}
