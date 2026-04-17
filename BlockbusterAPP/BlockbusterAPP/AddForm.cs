using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace BlockbusterApp
{
    public class AddForm : Form
    {
        public Dictionary<string, object> Values = new Dictionary<string, object>();

        string connectionString =
            @"Server=localhost\SQLEXPRESS;Database=Blockbuster;Trusted_Connection=True;";

        string currentTable;

        public AddForm(List<string> fields, string table)
        {
            currentTable = table;

            this.Text = "Add New Record";
            this.Width = 350;
            this.Height = 70 + (fields.Count * 35);

            int top = 20;

            foreach (var field in fields)
            {
                Label lbl = new Label()
                {
                    Text = field,
                    Left = 10,
                    Top = top,
                    Width = 130
                };

                Control input;

                // 🎯 ONLY use dropdowns for relational tables
                if (IsRelationalTable(table) && IsForeignKey(field))
                {
                    ComboBox cb = new ComboBox()
                    {
                        Name = field,
                        Left = 150,
                        Top = top,
                        Width = 150,
                        DropDownStyle = ComboBoxStyle.DropDownList
                    };

                    LoadComboData(cb, field);
                    input = cb;
                }
                else if (field.Contains("Date"))
                {
                    DateTimePicker dt = new DateTimePicker()
                    {
                        Name = field,
                        Left = 150,
                        Top = top,
                        Width = 150
                    };
                    input = dt;
                }
                else
                {
                    TextBox txt = new TextBox()
                    {
                        Name = field,
                        Left = 150,
                        Top = top,
                        Width = 150
                    };
                    input = txt;
                }

                this.Controls.Add(lbl);
                this.Controls.Add(input);

                top += 35;
            }

            Button btnOK = new Button()
            {
                Text = "Add",
                Left = 120,
                Top = top + 10,
                Width = 100
            };

            btnOK.Click += (s, e) =>
            {
                foreach (Control c in this.Controls)
                {
                    if (c is TextBox txt)
                        Values[c.Name] = txt.Text;

                    else if (c is ComboBox cb)
                    {
                        if (cb.SelectedValue == null)
                        {
                            MessageBox.Show($"Please select {cb.Name}");
                            return;
                        }
                        Values[c.Name] = cb.SelectedValue;
                    }

                    else if (c is DateTimePicker dt)
                        Values[c.Name] = dt.Value;
                }

                this.DialogResult = DialogResult.OK;
                this.Close();
            };

            this.Controls.Add(btnOK);
        }

        // 🔹 Identify relational tables
        private bool IsRelationalTable(string table)
        {
            return table == "Rents" ||
                   table == "Stocks" ||
                   table == "Dependants" ||
                   table == "Revenue";
        }

        // 🔹 Identify foreign key fields
        private bool IsForeignKey(string field)
        {
            return field.EndsWith("_ID") || field == "Work_SSN";
        }

        // 🔽 Load dropdown data
        private void LoadComboData(ComboBox cb, string field)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string query = "";

                if (field == "Customer_ID")
                    query = "SELECT Customer_ID FROM Customers";

                else if (field == "Product_ID")
                    query = "SELECT Product_ID FROM Product";

                else if (field == "Store_ID")
                    query = "SELECT Store_ID FROM Stores";

                else if (field == "Work_SSN")
                    query = "SELECT Work_SSN FROM Workers";

                if (query != "")
                {
                    SqlDataAdapter da = new SqlDataAdapter(query, con);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    cb.DataSource = dt;
                    cb.DisplayMember = dt.Columns[0].ColumnName;
                    cb.ValueMember = dt.Columns[0].ColumnName;
                }
            }
        }
    }
}