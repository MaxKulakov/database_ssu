using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp1
{
    public partial class post : Form
    {
        SqlConnection SqlConnection;
        public post()
        {
            InitializeComponent();
        }

        private async void post_Load(object sender, EventArgs e)
        {
            string connectionString = @"Data Source=MAXKULAKOV8A04;Initial Catalog=university;Integrated Security=True";
            SqlConnection = new SqlConnection(connectionString);
            await SqlConnection.OpenAsync();
            SqlDataReader sqlReader = null;
            SqlCommand command = new SqlCommand("select * from [dbo].[post]", SqlConnection);

            try
            {
                sqlReader = await command.ExecuteReaderAsync();
                while (await sqlReader.ReadAsync())
                {
                    listBox1.Items.Add(Convert.ToString(sqlReader["ID_post"]) + "        " + Convert.ToString(sqlReader["id_blogger"]) + "        " + Convert.ToString(sqlReader["Name_post"]) + "        " + Convert.ToString(sqlReader["content"]) + "        " + Convert.ToString(sqlReader["date_post"]) + "        " + Convert.ToString(sqlReader["views_post"]));
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), ex.Source.ToString(), MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                if (sqlReader != null)
                    sqlReader.Close();
            }
        }

        private async void button1_Click(object sender, EventArgs e)
        {
            SqlCommand command = new SqlCommand("INSERT INTO [post] VALUES (@1, @2, @3, @4, @5)", SqlConnection);
            command.Parameters.AddWithValue("1", textBox1.Text);
            command.Parameters.AddWithValue("2", textBox2.Text);
            command.Parameters.AddWithValue("3", textBox3.Text);
            command.Parameters.AddWithValue("4", textBox9.Text);
            command.Parameters.AddWithValue("5", textBox11.Text);
            await command.ExecuteNonQueryAsync();
        }

        private async void button2_Click(object sender, EventArgs e)
        {
            SqlCommand command = new SqlCommand("UPDATE [post] SET id_blogger = @1, Name_post = @2, content = @3, date_post = @4, views_post = @6 WHERE ID_post = @5", SqlConnection);
            command.Parameters.AddWithValue("5", textBox9.Text);
            command.Parameters.AddWithValue("1", textBox8.Text);
            command.Parameters.AddWithValue("2", textBox7.Text);
            command.Parameters.AddWithValue("3", textBox6.Text);
            command.Parameters.AddWithValue("4", textBox5.Text);
            command.Parameters.AddWithValue("6", textBox12.Text);
            await command.ExecuteNonQueryAsync();
        }

        private async void button3_Click(object sender, EventArgs e)
        {
            SqlCommand command = new SqlCommand("DELETE FROM [post] WHERE ID_post = @ID_post", SqlConnection);
            command.Parameters.AddWithValue("ID_post", textBox10.Text);
            await command.ExecuteNonQueryAsync();
        }

        private async void обновитьToolStripMenuItem_Click(object sender, EventArgs e)
        {
            listBox1.Items.Clear();

            SqlDataReader sqlReader = null;
            SqlCommand command = new SqlCommand("SELECT * FROM [dbo].[post]", SqlConnection);

            try
            {
                sqlReader = await command.ExecuteReaderAsync();
                while (await sqlReader.ReadAsync())
                {
                    listBox1.Items.Add(Convert.ToString(sqlReader["ID_post"]) + "        " + Convert.ToString(sqlReader["id_blogger"]) + "        " + Convert.ToString(sqlReader["Name_post"]) + "        " + Convert.ToString(sqlReader["content"]) + "        " + Convert.ToString(sqlReader["date_post"]) + "        " + Convert.ToString(sqlReader["views_post"]));
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString(), ex.Source.ToString(), MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                if (sqlReader != null)
                    sqlReader.Close();
            }
        }
    }
}
