// Copyright (c) 2019 ActivePDF, Inc.
// ActivePDF Reader Plus

using System;
using System.IO;
using System.Web.Services;

public partial class Basic_implementation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {        
    }

    [WebMethod]
    public static string GetPDFData()
    {
        return Convert.ToBase64String(File.ReadAllBytes(AppDomain.CurrentDomain.BaseDirectory + "ReaderPlusSample.pdf"));
    }

}
