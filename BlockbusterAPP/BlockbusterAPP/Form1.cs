using System;
using System.Collections.Generic;
using System.Data;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace BlockbusterApp
{
    public partial class Form1 : Form
    {
        DatabaseHelper db = new DatabaseHelper();

        public Form1()
        {
            InitializeComponent();
            LoadTables();
            btnLoad.Click += btnLoad_Click;
            btnAdd.Click += btnAdd_Click;
            btnDelete.Click += btnDelete_Click;

            dataGridView1.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            dataGridView1.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dataGridView1.MultiSelect = false;
            dataGridView1.ReadOnly = true;
        }

        private void LoadTables()
        {
            cmbTables.Items.AddRange(new string[]
            {
                "Product",
                "Customers",
                "Workers",
                "Rents",
                "Dependants",
                "Stores",
                "StoreCards",
                "Revenue",
                "Stocks"
            });
        }
        private void btnLoad_Click(object sender, EventArgs e)
        {
            if (cmbTables.SelectedItem == null)
            {
                MessageBox.Show("Please select a table first.");
                return;
            }

            string table = cmbTables.SelectedItem.ToString();
            string query = $"SELECT * FROM {table}";

            dataGridView1.DataSource = db.GetData(query);
        }
        private void btnAdd_Click(object sender, EventArgs e)
        {
            if (cmbTables.SelectedItem == null)
            {
                MessageBox.Show("Select a table first");
                return;
            }

            string table = cmbTables.SelectedItem.ToString();

            try
            {
                List<string> fields = new List<string>();
                string query = "";

                if (table == "Customers")
                {
                    fields.AddRange(new[] { "First_Name", "last_Name", "PhoneNo", "Email", "Fines" });
                }
                else if (table == "Rents")
                {
                    fields.AddRange(new[] { "Customer_ID", "Product_ID", "Return_by_Date", "Late_Fees" });
                }
                else if (table == "Dependants")
                {
                    fields.AddRange(new[] { "First_Name", "last_Name", "Gender", "Date_Of_Birth", "Work_SSN" });
                }
                else if (table == "Stocks")
                {
                    fields.AddRange(new[] { "Store_ID", "Product_ID", "InStock", "Copies_Borrowed" });
                }
                else if (table == "Revenue")
                {
                    fields.AddRange(new[] { "Store_ID", "Year", "Store_Revenue" });
                }
                else if (table == "Product")
                {
                    fields.AddRange(new[] { "Title", "Age_Rating", "type", "Release_Date", "Creator", "Price" });
                }
                else if (table == "Workers")
                {
                    fields.AddRange(new[] { "First_Name", "last_Name", "Salary", "Start_Date", "Position", "Store_ID" });
                }
                else if (table == "Stores")
                {
                    fields.AddRange(new[] { "Address", "open_Date" });
                }
                else if (table == "StoreCards")
                {
                    fields.AddRange(new[] { "Benefits_Level", "Status", "Expiration_Date", "Customer_ID" });
                }

                AddForm form = new AddForm(fields, table);

                if (form.ShowDialog() == DialogResult.OK)
                {
                    var values = form.Values;

                    string columns = string.Join(",", fields);
                    string parameters = string.Join(",", fields.ConvertAll(f => "@" + f));

                    query = $"INSERT INTO {table} ({columns}) VALUES ({parameters})";

                    List<System.Data.SqlClient.SqlParameter> paramList = new List<System.Data.SqlClient.SqlParameter>();

                    foreach (var f in fields)
                    {
                        paramList.Add(new SqlParameter("@" + f, values[f] ?? DBNull.Value));
                    }

                    db.ExecuteQuery(query, paramList.ToArray());

                    MessageBox.Show("Added successfully!");
                    btnLoad.PerformClick();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        private void btnDelete_Click(object sender, EventArgs e)
        {
            if (dataGridView1.CurrentRow == null) return;
            if (cmbTables.SelectedItem == null) return;

            string table = cmbTables.SelectedItem.ToString();

            try
            {
                var row = dataGridView1.CurrentRow;

                if (table == "Rents")
                {
                    int c = Convert.ToInt32(row.Cells["Customer_ID"].Value);
                    int p = Convert.ToInt32(row.Cells["Product_ID"].Value);
                    DateTime d = Convert.ToDateTime(row.Cells["Return_by_Date"].Value);

                    string query = @"DELETE FROM Rents 
                             WHERE Customer_ID=@c 
                             AND Product_ID=@p 
                             AND Return_by_Date=@d";

                    db.ExecuteQuery(query, new[]
                    {
                new System.Data.SqlClient.SqlParameter("@c", c),
                new System.Data.SqlClient.SqlParameter("@p", p),
                new System.Data.SqlClient.SqlParameter("@d", d)
            });
                }
                else if (table == "Stocks")
                {
                    int s = Convert.ToInt32(row.Cells["Store_ID"].Value);
                    int p = Convert.ToInt32(row.Cells["Product_ID"].Value);

                    string query = @"DELETE FROM Stocks 
                             WHERE Store_ID=@s AND Product_ID=@p";

                    db.ExecuteQuery(query, new[]
                    {
                new System.Data.SqlClient.SqlParameter("@s", s),
                new System.Data.SqlClient.SqlParameter("@p", p)
            });
                }
                else if (table == "Revenue")
                {
                    int s = Convert.ToInt32(row.Cells["Store_ID"].Value);
                    int y = Convert.ToInt32(row.Cells["Year"].Value);

                    string query = @"DELETE FROM Revenue 
                             WHERE Store_ID=@s AND Year=@y";

                    db.ExecuteQuery(query, new[]
                    {
                new System.Data.SqlClient.SqlParameter("@s", s),
                new System.Data.SqlClient.SqlParameter("@y", y)
            });
                }
                else if (table == "Dependants")
                {
                    int ssn = Convert.ToInt32(row.Cells["Work_SSN"].Value);
                    string fn = row.Cells["First_Name"].Value.ToString();
                    string ln = row.Cells["last_Name"].Value.ToString();

                    string query = @"DELETE FROM Dependants 
                             WHERE Work_SSN=@s 
                             AND First_Name=@f 
                             AND last_Name=@l";

                    db.ExecuteQuery(query, new[]
                    {
                new System.Data.SqlClient.SqlParameter("@s", ssn),
                new System.Data.SqlClient.SqlParameter("@f", fn),
                new System.Data.SqlClient.SqlParameter("@l", ln)
            });
                }
                else if (table == "Workers")
                {
                    int id = Convert.ToInt32(row.Cells["Work_SSN"].Value);

                    try
                    {
                        db.ExecuteQuery("DELETE FROM Workers WHERE Work_SSN=@id",
                            new[] { new SqlParameter("@id", id) });
                    }
                    catch
                    {
                        MessageBox.Show("Cannot delete worker: has dependants.");
                        return;
                    }
                }
                else if (table == "StoreCards")
                {
                    int c = Convert.ToInt32(row.Cells["Customer_ID"].Value);
                    DateTime d = Convert.ToDateTime(row.Cells["Expiration_Date"].Value);

                    string query = @"DELETE FROM StoreCards 
                     WHERE Customer_ID=@c AND Expiration_Date=@d";

                    db.ExecuteQuery(query, new[]
                    {
        new SqlParameter("@c", c),
        new SqlParameter("@d", d)
    });
                }

                else
                {
                    int id = Convert.ToInt32(row.Cells[0].Value);
                    string pk = GetPrimaryKey(table);

                    string query = $"DELETE FROM {table} WHERE {pk}=@id";

                    db.ExecuteQuery(query, new[]
                    {
                new System.Data.SqlClient.SqlParameter("@id", id)
            });
                }

                MessageBox.Show("Deleted successfully!");
                btnLoad.PerformClick();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        private string GetPrimaryKey(string table)
        {
            switch (table)
            {
                case "Product": return "Product_ID";
                case "Customers": return "Customer_ID";
                case "Workers": return "Work_SSN";
                case "Stores": return "Store_ID";
                case "StoreCards": return "Customer_ID";
                default: return "Customer_ID";
            }
        }
        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            
        }
    }
}