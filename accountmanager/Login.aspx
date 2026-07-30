<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs"
    Inherits="accountmanager.Login" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Login</title>
</head>
<body>
<form id="form1" runat="server">

    <h1>Login to Account</h1>

    <p>Email</p>
    <asp:TextBox ID="txtEmail" runat="server" />

    <p>Password</p>
    <asp:TextBox ID="txtPassword"
        runat="server"
        TextMode="Password" />

    <br /><br />

    <asp:Button ID="btnLogin"
        runat="server"
        Text="Login"
        OnClick="btnLogin_Click" />

    <br /><br />

    <asp:Label ID="lblMessage" runat="server" />

</form>
</body>
</html>