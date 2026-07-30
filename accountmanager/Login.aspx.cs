using System;
using System.Security.Cryptography;
using System.Text;
using MySql.Data.MySqlClient;

namespace accountmanager
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim().ToLower();
            string password = txtPassword.Text;

            if (email == "" || password == "")
            {
                lblMessage.Text = "Please enter your email and password.";
                return;
            }

            string connectionString =
                System.Configuration.ConfigurationManager
                .ConnectionStrings["teamDB"]
                .ConnectionString;

            try
            {
                string passwordHash = HashPassword(password);

                using (MySqlConnection connection =
                    new MySqlConnection(connectionString))
                {
                    connection.Open();

                    string sql =
                        @"SELECT user_id, first_name, last_name, role
                          FROM users
                          WHERE email = @email
                          AND password_hash = @passwordHash";

                    using (MySqlCommand command =
                        new MySqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@email", email);
                        command.Parameters.AddWithValue("@passwordHash", passwordHash);

                        using (MySqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                Session["UserId"] = reader["user_id"].ToString();
                                Session["FirstName"] = reader["first_name"].ToString();
                                Session["Role"] = reader["role"].ToString();

                                lblMessage.Text =
                                    "Login successful. Welcome " +
                                    reader["first_name"].ToString() + "!";
                            }
                            else
                            {
                                lblMessage.Text =
                                    "Invalid email or password.";
                            }
                        }
                    }
                }
            }
            catch (Exception)
            {
                lblMessage.Text = "Unable to log in.";
            }
        }

        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes =
                    sha256.ComputeHash(
                        Encoding.UTF8.GetBytes(password));

                StringBuilder builder = new StringBuilder();

                foreach (byte b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }

                return builder.ToString();
            }
        }
    }
}