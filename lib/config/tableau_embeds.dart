/// HTML snippets for embedding Tableau vizzes in a WebView.
///
/// We use direct iframe embeds so sizing is stable on mobile.
const String kUnemploymentOverviewTableauEmbedHtml = r'''
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>
      html, body {
        margin: 0;
        padding: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
        background: #ffffff;
      }
      .frameWrap {
        width: 100%;
        height: 100%;
      }
      iframe {
        display: block;
        width: 100%;
        height: 100%;
        border: 0;
      }
    </style>
  </head>
  <body>
    <div class="frameWrap">
      <iframe
        src="https://public.tableau.com/views/3_OverviewPengangguran/3_Dash_unemploy_overview?:showVizHome=no&:tabs=no&:toolbar=no&:device=phone"
        title="Overview Pengangguran"
      ></iframe>
    </div>
  </body>
</html>
''';

const String kWorkOverviewTableauEmbedHtml = r'''
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>
      html, body {
        margin: 0;
        padding: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
        background: #ffffff;
      }
      .frameWrap {
        width: 100%;
        height: 100%;
      }
      iframe {
        display: block;
        width: 100%;
        height: 100%;
        border: 0;
      }
    </style>
  </head>
  <body>
    <div class="frameWrap">
      <iframe
        src="https://public.tableau.com/views/1_OverviewPendudukBekerja/1_Dash_work_overview?:showVizHome=no&:tabs=no&:toolbar=no&:device=phone"
        title="Overview Penduduk Bekerja"
      ></iframe>
    </div>
  </body>
</html>
''';

const String kTptEducationTableauEmbedHtml = r'''
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>
      html, body {
        margin: 0;
        padding: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
        background: #ffffff;
      }
      .frameWrap {
        width: 100%;
        height: 100%;
      }
      iframe {
        display: block;
        width: 100%;
        height: 100%;
        border: 0;
      }
    </style>
  </head>
  <body>
    <div class="frameWrap">
      <iframe
        src="https://public.tableau.com/views/3_TPTMenurutPendidikan/3_Dash_TPTedu?:showVizHome=no&:tabs=no&:toolbar=no&:device=phone"
        title="TPT Menurut Pendidikan"
      ></iframe>
    </div>
  </body>
</html>
''';

const String kLaborForceOverviewTableauEmbedHtml = r'''
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>
      html, body {
        margin: 0;
        padding: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
        background: #ffffff;
      }
      .frameWrap {
        width: 100%;
        height: 100%;
      }
      iframe {
        display: block;
        width: 100%;
        height: 100%;
        border: 0;
      }
    </style>
  </head>
  <body>
    <div class="frameWrap">
      <iframe
        src="https://public.tableau.com/views/2_OverviewAngkatanKerja/2_Dash_angkatan_overview?:showVizHome=no&:tabs=no&:toolbar=no&:device=phone"
        title="Overview Angkatan Kerja"
      ></iframe>
    </div>
  </body>
</html>
''';


