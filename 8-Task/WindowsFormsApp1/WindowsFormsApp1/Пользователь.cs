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
    public partial class Пользователь : Form
    {
        SqlConnection SqlConnection;
        public Пользователь()
        {
            InitializeComponent();
        }

        private async void button1_Click(object sender, EventArgs e)
        {
            listBox1.Items.Clear();
            string connectionString = @"Data Source=MAXKULAKOV8A04;Initial Catalog=university;Integrated Security=True";
            SqlConnection = new SqlConnection(connectionString);
            await SqlConnection.OpenAsync();
            SqlDataReader sqlReader = null;
            SqlCommand command = new SqlCommand("select [Name_post], [content], [views_post] from[dbo].[post] where[id_blogger] = @1", SqlConnection);
            command.Parameters.AddWithValue("1", textBox1.Text);

            try
            {
                sqlReader = await command.ExecuteReaderAsync();
                while (await sqlReader.ReadAsync())
                {
                    listBox1.Items.Add(Convert.ToString(sqlReader["Name_post"]) + "        " + Convert.ToString(sqlReader["content"]) + "        " + Convert.ToString(sqlReader["views_post"]));
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

        private async void button2_Click(object sender, EventArgs e)
        {
            listBox1.Items.Clear();
            string connectionString = @"Data Source=MAXKULAKOV8A04;Initial Catalog=university;Integrated Security=True";
            SqlConnection = new SqlConnection(connectionString);
            await SqlConnection.OpenAsync();
            SqlDataReader sqlReader = null;
            SqlCommand command = new SqlCommand("select distinct [Name_blogger], [language_blogger] from[dbo].[post] p join[dbo].[comment] c on c.[id_post] = p.[ID_post] join[dbo].[blogger] b on b.[ID_blogger] = c.[id_blogger] where p.[id_blogger] = @1", SqlConnection);
            command.Parameters.AddWithValue("1", textBox1.Text);

            try
            {
                sqlReader = await command.ExecuteReaderAsync();
                while (await sqlReader.ReadAsync())
                {
                    listBox1.Items.Add(Convert.ToString(sqlReader["Name_blogger"]) + "        " + Convert.ToString(sqlReader["language_blogger"]));
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

        private async void button4_Click(object sender, EventArgs e)
        {
            listBox2.Items.Clear();
            string connectionString = @"Data Source=MAXKULAKOV8A04;Initial Catalog=university;Integrated Security=True";
            SqlConnection = new SqlConnection(connectionString);
            await SqlConnection.OpenAsync();
            SqlDataReader sqlReader = null;
            SqlCommand command = new SqlCommand("select [Name_post], [views_post] from[dbo].[post] p where p.[id_blogger] = @1", SqlConnection);
            command.Parameters.AddWithValue("1", textBox2.Text);

            try
            {
                sqlReader = await command.ExecuteReaderAsync();
                while (await sqlReader.ReadAsync())
                {
                    listBox2.Items.Add(Convert.ToString(sqlReader["Name_post"]) + "        " + Convert.ToString(sqlReader["views_post"]));
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
            listBox2.Items.Clear();
            string connectionString = @"Data Source=MAXKULAKOV8A04;Initial Catalog=university;Integrated Security=True";
            SqlConnection = new SqlConnection(connectionString);
            await SqlConnection.OpenAsync();
            SqlDataReader sqlReader = null;
            SqlCommand command = new SqlCommand("select [Name_post], [views_post] from[dbo].[post] p where p.[id_blogger] = @1 order by([views_post])", SqlConnection);
            command.Parameters.AddWithValue("1", textBox2.Text);

            try
            {
                sqlReader = await command.ExecuteReaderAsync();
                while (await sqlReader.ReadAsync())
                {
                    listBox2.Items.Add(Convert.ToString(sqlReader["Name_post"]) + "        " + Convert.ToString(sqlReader["views_post"]));
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

        private async void button5_Click(object sender, EventArgs e)
        {
            listBox2.Items.Clear();
            string connectionString = @"Data Source=MAXKULAKOV8A04;Initial Catalog=university;Integrated Security=True";
            SqlConnection = new SqlConnection(connectionString);
            await SqlConnection.OpenAsync();
            SqlDataReader sqlReader = null;
            SqlCommand command = new SqlCommand("exec totalExpensesSum @1", SqlConnection);
            command.Parameters.AddWithValue("1", textBox2.Text);

            try
            {
                sqlReader = await command.ExecuteReaderAsync();
                while (await sqlReader.ReadAsync())
                {
                    listBox2.Items.Add(Convert.ToString(sqlReader["Sum_agv"]));
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

        private async void button7_Click(object sender, EventArgs e)
        {
            listBox3.Items.Clear();
            string connectionString = @"Data Source=MAXKULAKOV8A04;Initial Catalog=university;Integrated Security=True";
            SqlConnection = new SqlConnection(connectionString);
            await SqlConnection.OpenAsync();
            SqlDataReader sqlReader = null;
            SqlCommand command = new SqlCommand("exec Sum_2; select * from New order by (S) desc; delete from New", SqlConnection);

            try
            {
                sqlReader = await command.ExecuteReaderAsync();
                while (await sqlReader.ReadAsync())
                {
                    listBox3.Items.Add(Convert.ToString(sqlReader["N"]) + "        " + Convert.ToString(sqlReader["S"]));
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

        private async void button6_Click(object sender, EventArgs e)
        {
            listBox3.Items.Clear();
            string connectionString = @"Data Source=MAXKULAKOV8A04;Initial Catalog=university;Integrated Security=True";
            SqlConnection = new SqlConnection(connectionString);
            await SqlConnection.OpenAsync();
            SqlDataReader sqlReader = null;
            SqlCommand command = new SqlCommand("exec Sum_2_; select * from New_ order by (S) desc; delete from New_ ", SqlConnection);

            try
            {
                sqlReader = await command.ExecuteReaderAsync();
                while (await sqlReader.ReadAsync())
                {
                    listBox3.Items.Add(Convert.ToString(sqlReader["N"]) + "        " + Convert.ToString(sqlReader["S"]));
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
