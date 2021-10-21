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
    public partial class Администратор : Form
    {
        public Администратор()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            blogger newForm = new blogger();
            newForm.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            post newForm = new post();
            newForm.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            comment newForm = new comment();
            newForm.Show();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            theme newForm = new theme();
            newForm.Show();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            post_theme newForm = new post_theme();
            newForm.Show();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            moderator newForm = new moderator();
            newForm.Show();
        }
    }
}
