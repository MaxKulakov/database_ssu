using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp1
{
    public partial class Страница_входа : Form
    {
        public Страница_входа()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string login = textBox1.Text;
            string password = textBox2.Text;
            if (login == "admin" && password == "56123")
            {
                Администратор newForm = new Администратор();
                newForm.Show();
            }
            else if (login == "Max" && password == "1234")
            {
                Пользователь newForm = new Пользователь();
                newForm.Show();
            }
            else
            {
                MessageBox.Show("Invalid Login or Password");
            }
        }
    }
}
