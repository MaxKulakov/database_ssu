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
    public partial class blogger : Form
    {
        SqlConnection SqlConnection;
        public blogger()
        {
            InitializeComponent();
        }

        private async void blogger_Load(object sender, EventArgs e)
        {
            string connectionString = @"Data Source=MAXKULAKOV8A04;Initial Catalog=university;Integrated Security=True";
            SqlConnection = new SqlConnection(connectionString);
            await SqlConnection.OpenAsync();
            SqlDataReader sqlReader = null;
            SqlCommand command = new SqlCommand("select * from [dbo].[blogger]", SqlConnection);

            try
            {
                sqlReader = await command.ExecuteReaderAsync();
                while (await sqlReader.ReadAsync())
                {
                    listBox1.Items.Add(Convert.ToString(sqlReader["ID_blogger"]) + "        " + Convert.ToString(sqlReader["Name_blogger"]) + "        " + Convert.ToString(sqlReader["date_of_birth"]) + "        " + Convert.ToString(sqlReader["registration_date"]) + "        " + Convert.ToString(sqlReader["language_blogger"]));
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

        private async void button3_Click(object sender, EventArgs e)
        {
            SqlCommand command = new SqlCommand("DELETE FROM [Blogger] WHERE ID_blogger = @ID_blogger", SqlConnection);
            command.Parameters.AddWithValue("ID_blogger", textBox10.Text);
            await command.ExecuteNonQueryAsync();
        }

        private async void button1_Click(object sender, EventArgs e)
        {
            SqlCommand command = new SqlCommand("INSERT INTO [Blogger] VALUES (@1, @2, @3, @4)", SqlConnection);
            command.Parameters.AddWithValue("1", textBox1.Text);
            command.Parameters.AddWithValue("2", textBox2.Text);
            command.Parameters.AddWithValue("3", textBox3.Text);
            command.Parameters.AddWithValue("4", textBox9.Text);
            await command.ExecuteNonQueryAsync();
        }

        private async void button2_Click(object sender, EventArgs e)
        {
            SqlCommand command = new SqlCommand("UPDATE [Blogger] SET Name_blogger = @1, date_of_birth = @2, registration_date = @3, language_blogger = @4 WHERE ID_blogger = @5", SqlConnection);
            command.Parameters.AddWithValue("5", textBox9.Text);
            command.Parameters.AddWithValue("1", textBox8.Text);
            command.Parameters.AddWithValue("2", textBox7.Text);
            command.Parameters.AddWithValue("3", textBox6.Text);
            command.Parameters.AddWithValue("4", textBox5.Text);
            await command.ExecuteNonQueryAsync();
        }

        private async void обновитьToolStripMenuItem_Click_1(object sender, EventArgs e)
        {
            listBox1.Items.Clear();

            SqlDataReader sqlReader = null;
            SqlCommand command = new SqlCommand("SELECT * FROM [dbo].[blogger]", SqlConnection);

            try
            {
                sqlReader = await command.ExecuteReaderAsync();
                while (await sqlReader.ReadAsync())
                {
                    listBox1.Items.Add(Convert.ToString(sqlReader["ID_blogger"]) + "        " + Convert.ToString(sqlReader["Name_blogger"]) + "        " + Convert.ToString(sqlReader["date_of_birth"]) + "        " + Convert.ToString(sqlReader["registration_date"]) + "        " + Convert.ToString(sqlReader["language_blogger"]));
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
