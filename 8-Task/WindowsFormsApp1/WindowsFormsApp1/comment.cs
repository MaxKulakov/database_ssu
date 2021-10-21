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
    public partial class comment : Form
    {
        SqlConnection SqlConnection;
        public comment()
        {
            InitializeComponent();
        }

        private async void comment_Load(object sender, EventArgs e)
        {
            string connectionString = @"Data Source=MAXKULAKOV8A04;Initial Catalog=university;Integrated Security=True";
            SqlConnection = new SqlConnection(connectionString);
            await SqlConnection.OpenAsync();
            SqlDataReader sqlReader = null;
            SqlCommand command = new SqlCommand("select * from [dbo].[comment]", SqlConnection);

            try
            {
                sqlReader = await command.ExecuteReaderAsync();
                while (await sqlReader.ReadAsync())
                {
                    listBox1.Items.Add(Convert.ToString(sqlReader["ID_comment"]) + "        " + Convert.ToString(sqlReader["id_blogger"]) + "        " + Convert.ToString(sqlReader["id_post"]) + "        " + Convert.ToString(sqlReader["date_comment"]));
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
            SqlCommand command = new SqlCommand("INSERT INTO [comment] VALUES (@1, @2, @3)", SqlConnection);
            command.Parameters.AddWithValue("1", textBox1.Text);
            command.Parameters.AddWithValue("2", textBox2.Text);
            command.Parameters.AddWithValue("3", textBox3.Text);
            await command.ExecuteNonQueryAsync();
        }

        private async void button2_Click(object sender, EventArgs e)
        {
            SqlCommand command = new SqlCommand("UPDATE [comment] SET id_blogger = @1, id_post = @2, date_comment = @3 WHERE ID_comment = @5", SqlConnection);
            command.Parameters.AddWithValue("5", textBox9.Text);
            command.Parameters.AddWithValue("1", textBox8.Text);
            command.Parameters.AddWithValue("2", textBox7.Text);
            command.Parameters.AddWithValue("3", textBox6.Text);
            await command.ExecuteNonQueryAsync();
        }

        private async void button3_Click(object sender, EventArgs e)
        {
            SqlCommand command = new SqlCommand("DELETE FROM [comment] WHERE ID_comment = @ID_comment", SqlConnection);
            command.Parameters.AddWithValue("ID_comment", textBox10.Text);
            await command.ExecuteNonQueryAsync();
        }

        private async void обновитьToolStripMenuItem_Click(object sender, EventArgs e)
        {
            listBox1.Items.Clear();

            SqlDataReader sqlReader = null;
            SqlCommand command = new SqlCommand("SELECT * FROM [dbo].[comment]", SqlConnection);

            try
            {
                sqlReader = await command.ExecuteReaderAsync();
                while (await sqlReader.ReadAsync())
                {
                    listBox1.Items.Add(Convert.ToString(sqlReader["ID_comment"]) + "        " + Convert.ToString(sqlReader["id_blogger"]) + "        " + Convert.ToString(sqlReader["id_post"]) + "        " + Convert.ToString(sqlReader["date_comment"]));
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
