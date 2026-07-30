<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="CreateAccount.aspx.cs"
    Inherits="accountmanager.CreateAccount" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Create Account</title>
</head>
<body>
<form id="form1" runat="server">

    <h1>Create User Account</h1>

    <p>First Name</p>
    <asp:TextBox ID="txtFirstName" runat="server" />

    <p>Last Name</p>
    <asp:TextBox ID="txtLastName" runat="server" />

    <p>Email</p>
    <asp:TextBox ID="txtEmail" runat="server" />

    <p>Password</p>
    <asp:TextBox ID="txtPassword"
        runat="server"
        TextMode="Password" />

    <p>Confirm Password</p>
    <asp:TextBox ID="txtConfirmPassword"
        runat="server"
        TextMode="Password" />

    <br /><br />

    <asp:Button ID="btnCreateAccount"
        runat="server"
        Text="Create Account"
        OnClick="btnCreateAccount_Click" />

    <br /><br />

    <asp:Label ID="lblMessage" runat="server" />

</form>
</body>
</html>