// Copyright (c) 2017 ActivePDF, Inc.
// ActivePDF Reader Plus

using System;
using System.IO;
using System.Web.Services;

public partial class Prepopulate_Form : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    [WebMethod]
    public static string GetPDFData()
    {
        return Convert.ToBase64String(File.ReadAllBytes(AppDomain.CurrentDomain.BaseDirectory + "ReaderPlusForm.pdf"));
    }

}
