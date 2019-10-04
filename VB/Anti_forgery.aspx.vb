' Copyright (c) 2019 ActivePDF, Inc.
' ActivePDF Reader Plus

Option Strict Off
Imports System.IO
Imports System.Web.Services

Partial Class Anti_Forgery
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    End Sub

    <WebMethod()>
    Public Shared Function GetPDFData() As String
        Return Convert.ToBase64String(File.ReadAllBytes(AppDomain.CurrentDomain.BaseDirectory + "ReaderPlusSample.pdf"))
    End Function
End Class
