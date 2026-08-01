using System;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;
using MySql.Data.MySqlClient;

namespace accountmanager
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // If the user is already logged in,
            // send them to the dashboard.
            if (Session["UserId"] != null)
            {
                Response.Redirect("Dashboard.aspx");
                return;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim().ToLower();
            string password = txtPassword.Text;

            if (string.IsNullOrWhiteSpace(email) ||
                string.IsNullOrWhiteSpace(password))
            {
                ShowError("Please enter your email and password.");
                return;
            }

            string passwordHash = HashPassword(password);

            string connectionString =
                ConfigurationManager
                    .ConnectionStrings["teamDB"]
                    .ConnectionString;

            // Role must be included in this query.
            string sql =
                @"SELECT
                      user_id,
                      first_name,
                      last_name,
                      email,
                      role
                  FROM users
                  WHERE email = @email
                    AND password_hash = @passwordHash
                  LIMIT 1;";

            try
            {
                using (MySqlConnection connection =
                    new MySqlConnection(connectionString))
                {
                    connection.Open();

                    using (MySqlCommand command =
                        new MySqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue(
                            "@email",
                            email);

                        command.Parameters.AddWithValue(
                            "@passwordHash",
                            passwordHash);

                        using (MySqlDataReader reader =
                            command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Save the logged-in user in Session.
                                Session["UserId"] =
                                    reader["user_id"].ToString();

                                Session["FirstName"] =
                                    reader["first_name"].ToString();

                                Session["LastName"] =
                                    reader["last_name"].ToString();

                                Session["Email"] =
                                    reader["email"].ToString();

                                Session["Role"] =
                                    reader["role"].ToString();

                                // Employee, Manager, and Admin
                                // all go to the same dashboard.
                                Response.Redirect("Dashboard.aspx");
                                return;
                            }
                        }
                    }
                }

                ShowError("Invalid email or password.");
            }
            catch (Exception)
            {
                ShowError("Unable to sign in. Please try again.");
            }
        }

        private void ShowError(string message)
        {
            lblMessage.CssClass = "message message-error";
            lblMessage.Text = message;
        }

        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes =
                    sha256.ComputeHash(
                        Encoding.UTF8.GetBytes(password));

                StringBuilder builder =
                    new StringBuilder();

                foreach (byte value in bytes)
                {
                    builder.Append(value.ToString("x2"));
                }

                return builder.ToString();
            }
        }
    }
}