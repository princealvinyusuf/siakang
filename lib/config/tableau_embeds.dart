/// HTML snippets for embedding Tableau vizzes inside WebViews.
///
/// We load these via `WebViewController.loadHtmlString(...)`.
/// Keep the HTML self-contained and responsive (100% width/height).

/// "Overview Pengangguran" dashboard embed (Tableau Public).
///
/// Source: Tableau embed code (v3) adapted for responsive sizing in Flutter WebView.
const String kUnemploymentOverviewTableauEmbedHtml = r'''
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, maximum-scale=1.0"
    />
    <style>
      html,
      body {
        margin: 0;
        padding: 0;
        height: 100%;
        width: 100%;
        overflow: hidden;
        background: #ffffff;
      }
      .tableauPlaceholder {
        height: 100%;
        width: 100%;
      }
    </style>
  </head>
  <body>
    <div
      class="tableauPlaceholder"
      id="vizUnemploymentOverview"
      style="position: relative"
    >
      <noscript>
        <a href="#">
          <img
            alt="3. Dash_unemploy_overview"
            src="https://public.tableau.com/static/images/3_/3_OverviewPengangguran/3_Dash_unemploy_overview/1_rss.png"
            style="border: none"
          />
        </a>
      </noscript>
      <object class="tableauViz" style="display: none">
        <param name="host_url" value="https%3A%2F%2Fpublic.tableau.com%2F" />
        <param name="embed_code_version" value="3" />
        <param name="site_root" value="" />
        <param
          name="name"
          value="3_OverviewPengangguran/3_Dash_unemploy_overview"
        />
        <param name="tabs" value="no" />
        <param name="toolbar" value="yes" />
        <param
          name="static_image"
          value="https://public.tableau.com/static/images/3_/3_OverviewPengangguran/3_Dash_unemploy_overview/1.png"
        />
        <param name="animate_transition" value="yes" />
        <param name="display_static_image" value="yes" />
        <param name="display_spinner" value="yes" />
        <param name="display_overlay" value="yes" />
        <param name="display_count" value="yes" />
        <param name="language" value="en-GB" />
      </object>
    </div>
    <script type="text/javascript">
      var divElement = document.getElementById("vizUnemploymentOverview");
      var vizElement = divElement.getElementsByTagName("object")[0];
      vizElement.style.width = "100%";
      vizElement.style.height = "100%";
      var scriptElement = document.createElement("script");
      scriptElement.src = "https://public.tableau.com/javascripts/api/viz_v1.js";
      vizElement.parentNode.insertBefore(scriptElement, vizElement);
    </script>
  </body>
</html>
''';

/// "Overview Penduduk Bekerja" dashboard embed (Tableau Public).
///
/// Source: Tableau embed code (v3) adapted for responsive sizing in Flutter WebView.
const String kWorkOverviewTableauEmbedHtml = r'''
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, maximum-scale=1.0"
    />
    <style>
      html,
      body {
        margin: 0;
        padding: 0;
        height: 100%;
        width: 100%;
        overflow: hidden;
        background: #ffffff;
      }
      .tableauPlaceholder {
        height: 100%;
        width: 100%;
      }
    </style>
  </head>
  <body>
    <div class="tableauPlaceholder" id="vizWorkOverview" style="position: relative">
      <noscript>
        <a href="https://paskerid.kemnaker.go.id/">
          <img
            alt="1. Dash_work_overview"
            src="https://public.tableau.com/static/images/1_/1_OverviewPendudukBekerja/1_Dash_work_overview/1_rss.png"
            style="border: none"
          />
        </a>
      </noscript>
      <object class="tableauViz" style="display: none">
        <param name="host_url" value="https%3A%2F%2Fpublic.tableau.com%2F" />
        <param name="embed_code_version" value="3" />
        <param name="site_root" value="" />
        <param
          name="name"
          value="1_OverviewPendudukBekerja/1_Dash_work_overview"
        />
        <param name="tabs" value="no" />
        <param name="toolbar" value="yes" />
        <param
          name="static_image"
          value="https://public.tableau.com/static/images/1_/1_OverviewPendudukBekerja/1_Dash_work_overview/1.png"
        />
        <param name="animate_transition" value="yes" />
        <param name="display_static_image" value="yes" />
        <param name="display_spinner" value="yes" />
        <param name="display_overlay" value="yes" />
        <param name="display_count" value="yes" />
        <param name="language" value="en-US" />
        <param name="filter" value="publish=yes" />
      </object>
    </div>
    <script type="text/javascript">
      var divElement = document.getElementById("vizWorkOverview");
      var vizElement = divElement.getElementsByTagName("object")[0];
      vizElement.style.width = "100%";
      vizElement.style.height = "100%";
      var scriptElement = document.createElement("script");
      scriptElement.src = "https://public.tableau.com/javascripts/api/viz_v1.js";
      vizElement.parentNode.insertBefore(scriptElement, vizElement);
    </script>
  </body>
</html>
''';


