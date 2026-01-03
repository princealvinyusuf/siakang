/// Central place to manage Tableau URLs used by the app.
///
/// This app opens Tableau inside a WebView (`ReportDetailScreen`), so we use the
/// Tableau "views" URL with embed-friendly query params.
const String kDefaultTableauReportUrl =
    'https://public.tableau.com/views/DataCollectingDashboardV_2/Dashboard'
    '?:showVizHome=no&:tabs=no&:toolbar=yes';

/// Tableau Public URL for the "Overview Pengangguran" dashboard.
///
/// Useful for opening the viz full-screen (e.g. from Home -> "Open dashboard").
const String kUnemploymentOverviewTableauUrl =
    'https://public.tableau.com/views/3_OverviewPengangguran/3_Dash_unemploy_overview'
    '?:showVizHome=no&:tabs=no&:toolbar=yes';


