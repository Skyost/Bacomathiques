package fr.bacomathiques.activity;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.print.PrintAttributes;
import android.print.PrintDocumentAdapter;
import android.print.PrintManager;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdView;
import com.race604.drawable.wave.WaveDrawable;

import java.lang.ref.WeakReference;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;
import de.mateware.snacky.Snacky;
import fr.bacomathiques.R;
import fr.bacomathiques.adapter.AnnalsAdapter;
import fr.bacomathiques.lesson.LessonContent;
import fr.bacomathiques.lesson.LessonSummary;
import fr.bacomathiques.task.GetLessonTask;
import fr.bacomathiques.util.Utils;
import im.delight.android.webview.AdvancedWebView;

/**
 * Represents the activity that allows to read a lesson.
 */

public class LessonActivity extends AppCompatActivity implements GetLessonTask.GetLessonListener {

	/**
	 * Anchor intent.
	 */

	private static final String INTENT_ANCHOR = "anchor";

	/**
	 * Content intent.
	 */

	private static final String INTENT_CONTENT = "content";

	/**
	 * Ads preferences.
	 */

	private static final String PREFERENCES_ADS = "ads-opt-in";

	/**
	 * Default webview client.
	 */

	private static final WebViewClient WEBVIEW_CLIENT = new WebViewClient() {

		@Override
		public final boolean shouldOverrideUrlLoading(final WebView view, final String url) {
			if(url.startsWith("file:///android_asset/") && !url.contains("/webview/") && (url.contains("/#") || url.endsWith("/"))) {
				final String[] parts = url.split("/#");

				final String id = parts[0].replace("file:///android_asset/", "").replace("/", "").replace("-", "_");
				final Context context = view.getContext();

				final Intent intent = new Intent(context, LessonActivity.class);
				intent.putExtra(MainActivity.INTENT_LESSON, new LessonSummary(id, null, null, null, null).getLessonURL());
				if(parts.length > 1) {
					intent.putExtra(INTENT_ANCHOR, parts[1]);
				}
				context.startActivity(intent);
			}
			else if(url.startsWith("http")) {
				launchBrowser(view.getContext(), Uri.parse(url));
			}
			return true;
		}

	};

	/**
	 * The current progress dialog instance.
	 */

	private ProgressDialog progressDialog;

	/**
	 * The current lesson content.
	 */

	private LessonContent content;

	/**
	 * The webview component.
	 */

	private AdvancedWebView webView;

	/**
	 * Launches the default web browser.
	 *
	 * @param context The context.
	 * @param uri The target url.
	 */

	private static void launchBrowser(final Context context, final Uri uri) {
		final Intent browserIntent = new Intent(Intent.ACTION_VIEW, uri);
		context.startActivity(browserIntent);
	}

	@Override
	protected void onCreate(final Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_lesson);

		webView = findViewById(R.id.lesson_webview);

		webView.getSettings().setUseWideViewPort(true);
		webView.getSettings().setBuiltInZoomControls(false);
		webView.getSettings().setDisplayZoomControls(false);
		webView.getSettings().setSupportZoom(false);
		webView.getSettings().setRenderPriority(WebSettings.RenderPriority.HIGH);
		webView.setHapticFeedbackEnabled(false);
		webView.setHorizontalScrollBarEnabled(false);
		webView.setWebViewClient(WEBVIEW_CLIENT);

		if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
			webView.setLayerType(View.LAYER_TYPE_HARDWARE, null);
		}
		else {
			webView.setLayerType(View.LAYER_TYPE_SOFTWARE, null);
		}

		if(savedInstanceState != null && savedInstanceState.containsKey(INTENT_CONTENT)) {
			onGetLessonDone((LessonContent)GetLessonTask.readLocalLessonContent(new WeakReference<>(this), savedInstanceState.getString(INTENT_CONTENT))[1]);
		}
		else {
			new GetLessonTask(this, this).execute(getIntent().getStringExtra(MainActivity.INTENT_LESSON));
		}

		final AdView adView = findViewById(R.id.lesson_adview);
		if(getPreferences(Context.MODE_PRIVATE).getBoolean(PREFERENCES_ADS, true)) {
			adView.loadAd(new AdRequest.Builder().build());
		}
		else {
			adView.setVisibility(View.GONE);
		}

		/*webView.setWebChromeClient(new WebChromeClient() {

			@Override
			public final boolean onConsoleMessage(final ConsoleMessage consoleMessage) {
				Log.d("WebView", consoleMessage.message());
				return true;
			}

		});*/
	}

	@Override
	protected void onResume() {
		webView.onResume();
		super.onResume();
	}

	@Override
	protected void onPause() {
		webView.onPause();
		if(progressDialog != null && progressDialog.isShowing()) {
			progressDialog.dismiss();
		}
		progressDialog = null;

		super.onPause();
	}

	@Override
	protected void onDestroy() {
		webView.onDestroy();
		super.onDestroy();
	}

	@Override
	protected void onSaveInstanceState(final Bundle outState) {
		if(content != null) {
			outState.putString(INTENT_CONTENT, content.getUrl());
		}

		super.onSaveInstanceState(outState);
	}

	@Override
	public boolean onCreateOptionsMenu(final Menu menu) {
		getMenuInflater().inflate(R.menu.menu_lesson, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		switch(item.getItemId()) {
		case android.R.id.home:
			onBackPressed();
			return true;
		case R.id.menu_lesson_action_annals:
			final List<String> annals = content.getAnnals();
			if(annals.isEmpty()) {
				new AlertDialog.Builder(this)
						.setTitle(R.string.dialog_lesson_annals_title)
						.setMessage(R.string.dialog_lesson_annals_empty)
						.setPositiveButton(android.R.string.ok, null)
						.show();
				return true;
			}

			new AlertDialog.Builder(this)
					.setTitle(R.string.dialog_lesson_annals_title)
					.setAdapter(new AnnalsAdapter(this, annals), (dialog, selected) -> {
						final String baseUrl = LessonSummary.BASE_URL + annals.get(selected);
						new AlertDialog.Builder(this)
								.setMessage(R.string.dialog_lesson_annalsask_message)
								.setPositiveButton(R.string.dialog_lesson_annalsask_positive, (dialogInterface, choice) -> launchBrowser(this, Uri.parse(baseUrl + "enonce.pdf")))
								.setNegativeButton(R.string.dialog_lesson_annalsask_negative, (dialogInterface, choice) -> launchBrowser(this, Uri.parse(baseUrl + "correction.pdf")))
								.show();
					})
					.setPositiveButton(android.R.string.cancel, null)
					.show();
			return true;
		case R.id.menu_lesson_action_share:
			final Intent sharingIntent = new Intent(android.content.Intent.ACTION_SEND);
			sharingIntent.setType("text/plain");
			sharingIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, getString(R.string.lesson_share_subject, content.getTitle(), getString(R.string.app_name)));
			sharingIntent.putExtra(android.content.Intent.EXTRA_TEXT, getString(R.string.lesson_share_content, content.getTitle()));
			startActivity(Intent.createChooser(sharingIntent, getString(R.string.lesson_share_title)));
			return true;
		case R.id.menu_lesson_action_save:
			launchBrowser(this, content.getPDFURL());
			return true;
		case R.id.menu_lesson_action_print:
			if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
				final PrintManager manager = (PrintManager)getSystemService(Context.PRINT_SERVICE);
				if(manager == null) {
					return true;
				}

				final PrintDocumentAdapter adapter;
				if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
					adapter = ((WebView)findViewById(R.id.lesson_webview)).createPrintDocumentAdapter(content.getTitle());
				}
				else {
					adapter = ((WebView)findViewById(R.id.lesson_webview)).createPrintDocumentAdapter();
				}
				manager.print(content.getTitle(), adapter, new PrintAttributes.Builder().build());
			}
			return true;
		case R.id.menu_lesson_action_ads:
			final SharedPreferences.Editor editor = getPreferences(Context.MODE_PRIVATE).edit();
			new AlertDialog.Builder(this)
					.setTitle(R.string.dialog_lesson_ads_title)
					.setMessage(R.string.dialog_lesson_ads_message)
					.setPositiveButton(R.string.dialog_lesson_ads_positive, (dialog, selected) -> editor.putBoolean(PREFERENCES_ADS, true))
					.setNegativeButton(R.string.dialog_lesson_ads_negative, (dialog, selected) -> editor.putBoolean(PREFERENCES_ADS, false))
					.setCancelable(false)
					.setOnDismissListener(dialog -> {
						editor.apply();
						new AlertDialog.Builder(this)
								.setMessage(R.string.dialog_lessons_adsconfirmation_message)
								.setPositiveButton(android.R.string.ok, null)
								.show();
					})
					.show();
			return true;
		case R.id.menu_lesson_action_rate:
			launchBrowser(this, Uri.parse("https://play.google.com/store/apps/details?id=fr.bacomathiques"));
			return true;
		case R.id.menu_lesson_action_report:
			launchBrowser(this, Uri.parse("https://github.com/Skyost/Bacomathiques/issues/new?title=[APP]%20Rapport%20de%20bug"));
			return true;
		case R.id.menu_lesson_action_about:
			new AlertDialog.Builder(this)
					.setTitle(R.string.dialog_lesson_about_title)
					.setMessage(Utils.fromHTML(getString(R.string.dialog_lesson_about_message)))
					.setNegativeButton(R.string.dialog_lesson_about_button_negative, null)
					.setNeutralButton(R.string.dialog_lesson_about_button_neutral, (dialogInterface, which) -> launchBrowser(LessonActivity.this, Uri.parse("https://bacomathiqu.es/a-propos/")))
					.setPositiveButton(R.string.dialog_lesson_about_button_positive, (dialogInterface, which) -> launchBrowser(LessonActivity.this, Uri.parse("https://play.google.com/store/apps/details?id=fr.bacomathiques")))
					.show();
			return true;
		}

		return super.onOptionsItemSelected(item);
	}

	@Override
	public void onGetLessonStarted() {
		final ActionBar actionBar = getSupportActionBar();
		if(actionBar != null) {
			actionBar.setTitle(R.string.activity_lesson_defaulttitle);
			actionBar.setDisplayHomeAsUpEnabled(true);
		}
		progressDialog = createProgressDialog();
		progressDialog.show();
	}

	@Override
	public void onGetLessonException(final Exception ex, final long offlineDate) {
		ex.printStackTrace();

		if(offlineDate != -1L) {
			final Calendar calendar = Calendar.getInstance();
			calendar.setTimeInMillis(offlineDate);

			Snacky.builder()
					.setActivity(this)
					.setText(getString(R.string.snackbar_offline, SimpleDateFormat.getDateInstance().format(calendar.getTime())))
					.setDuration(Snacky.LENGTH_LONG)
					.setBackgroundColor(ContextCompat.getColor(this, R.color.colorPrimaryDark))
					.info()
					.show();
		}
	}

	@Override
	public void onGetLessonDone(final LessonContent result) {
		content = result;

		if(progressDialog != null && progressDialog.isShowing()) {
			progressDialog.dismiss();
		}
		progressDialog = null;

		if(result == null) {
			new AlertDialog.Builder(this)
					.setTitle(R.string.dialog_generic_error)
					.setMessage(R.string.dialog_errorgetlesson_message)
					.setPositiveButton(android.R.string.ok, null)
					.setOnDismissListener(dialogInterface -> onBackPressed())
					.show();
			return;
		}

		final Intent intent = getIntent();

		final StringBuilder builder = new StringBuilder("<!DOCTYPE HTML>");
		builder.append("<html>");
		builder.append("<head>");
		builder.append("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>");
		builder.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\"/>");
		builder.append("<script type=\"text/javascript\">const BASE_URL = \"").append(LessonSummary.BASE_URL).append("\"; const PAGE_ID = \"").append(result.getId()).append("\";</script>");
		if(intent.hasExtra(INTENT_ANCHOR)) {
			builder.append("<script type=\"text/javascript\">const ANCHOR = \"").append(intent.getStringExtra(INTENT_ANCHOR)).append("\";</script>");
		}
		builder.append("<script type=\"text/javascript\" src=\"script.js\"></script>");
		builder.append("<script type=\"text/x-mathjax-config\">MathJax.Hub.Config({tex2jax: { inlineMath: [ ['$','$'], ['\\\\(','\\\\)'] ]},'HTML-CSS': { webFont: 'TeX', preferredFont: 'TeX', availableFonts: [ 'TeX' ], extensions: ['handle-floats.js']}, messageStyle: 'none', showMathMenu: false});</script>");
		builder.append("<script type=\"text/javascript\" src=\"mathjax/MathJax.js?config=TeX-AMS_HTML\"></script>");
		builder.append("</head>");
		builder.append("<body");
		if(getPreferences(Context.MODE_PRIVATE).getBoolean(PREFERENCES_ADS, true)) {
			builder.append(" style=\"margin-bottom: 60px\";");
		}
		builder.append(">");
		builder.append(result.getContent());
		builder.append("</body>");
		builder.append("</html>");

		webView.loadHtml(builder.toString(), "file:///android_asset/webview/");

		final ActionBar actionBar = getSupportActionBar();
		if(actionBar != null) {
			final String[] title = result.getTitle().split(" - ");

			actionBar.setTitle(title[0]);
			actionBar.setSubtitle(title[1]);
		}
	}

	/**
	 * Creates the progress dialog.
	 *
	 * @return The progress dialog.
	 */

	private ProgressDialog createProgressDialog() {
		final WaveDrawable indeterminate = new WaveDrawable(ContextCompat.getDrawable(this, R.mipmap.ic_launcher));
		indeterminate.setIndeterminate(true);

		final ProgressDialog progressDialog = new ProgressDialog(this);
		progressDialog.setMessage(getString(R.string.dialog_loading_message));
		progressDialog.setCancelable(false);
		progressDialog.setIndeterminateDrawable(indeterminate);

		return progressDialog;
	}

}