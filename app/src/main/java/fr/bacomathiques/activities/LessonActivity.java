package fr.bacomathiques.activities;

import android.annotation.SuppressLint;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.print.PrintAttributes;
import android.print.PrintDocumentAdapter;
import android.print.PrintManager;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import com.race604.drawable.wave.WaveDrawable;

import java.lang.ref.WeakReference;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import de.mateware.snacky.Snacky;
import fr.bacomathiques.R;
import fr.bacomathiques.lesson.LessonContent;
import fr.bacomathiques.lesson.LessonSummary;
import fr.bacomathiques.tasks.GetLessonTask;

public class LessonActivity extends AppCompatActivity implements GetLessonTask.GetLessonListener {

	private static final String INTENT_ANCHOR = "anchor";
	private static final String INTENT_CONTENT = "content";

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

	private ProgressDialog dialog;
	private LessonContent content;

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
	protected final void onCreate(final Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setContentView(R.layout.activity_lesson);

		final WebView webView = this.findViewById(R.id.lesson_webview);
		webView.getSettings().setJavaScriptEnabled(true);
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
			onGetLessonDone((LessonContent)GetLessonTask.readLocalLessonContent(new WeakReference<Context>(this), savedInstanceState.getString(INTENT_CONTENT))[1]);
		}
		else {
			new GetLessonTask(this, this).execute(this.getIntent().getStringExtra(MainActivity.INTENT_LESSON));
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
	public void onPause() {
		super.onPause();

		if(dialog != null && dialog.isShowing()) {
			dialog.dismiss();
		}
		dialog = null;
	}

	@Override
	protected final void onSaveInstanceState(final Bundle outState) {
		if(content != null) {
			outState.putString(INTENT_CONTENT, content.getUrl());
		}

		super.onSaveInstanceState(outState);
	}

	@Override
	public final boolean onCreateOptionsMenu(final Menu menu) {
		this.getMenuInflater().inflate(R.menu.menu_lesson, menu);
		return true;
	}

	@SuppressLint({"NewApi"})
	@Override
	public final boolean onOptionsItemSelected(MenuItem item) {
		switch(item.getItemId()) {
		case android.R.id.home:
			this.onBackPressed();
			return true;
		case R.id.menu_lesson_action_share:
			final Intent sharingIntent = new Intent(android.content.Intent.ACTION_SEND);
			sharingIntent.setType("text/plain");
			sharingIntent.putExtra(android.content.Intent.EXTRA_SUBJECT, this.getString(R.string.lesson_share_subject, content.getTitle(), this.getString(R.string.app_name)));
			sharingIntent.putExtra(android.content.Intent.EXTRA_TEXT, this.getString(R.string.lesson_share_content, content.getTitle()));
			this.startActivity(Intent.createChooser(sharingIntent, this.getString(R.string.lesson_share_title)));
			return true;
		case R.id.menu_lesson_action_save:
			launchBrowser(this, content.getPDFUrl());
			return true;
		case R.id.menu_lesson_action_print:
			if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
				final PrintManager manager = (PrintManager)this.getSystemService(Context.PRINT_SERVICE);
				if(manager == null) {
					return true;
				}

				final PrintDocumentAdapter adapter;
				if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
					adapter = ((WebView)this.findViewById(R.id.lesson_webview)).createPrintDocumentAdapter(content.getTitle());
				}
				else {
					adapter = ((WebView)this.findViewById(R.id.lesson_webview)).createPrintDocumentAdapter();
				}
				manager.print(content.getTitle(), adapter, new PrintAttributes.Builder().build());
			}
			return true;
		case R.id.menu_lesson_action_rate:
			launchBrowser(this, Uri.parse("https://play.google.com/store/apps/details?id=fr.bacomathiques"));
			return true;
		case R.id.menu_lesson_action_report:
			launchBrowser(this, Uri.parse("https://github.com/Skyost/Bacomathiques/issues/new?title=[APP]%20Rapport%20de%20bug"));
			return true;
		case R.id.menu_lesson_action_about:
			new AlertDialog.Builder(this).setTitle(R.string.dialog_lesson_about_title).setMessage(R.string.dialog_lesson_about_message).setNegativeButton(R.string.dialog_lesson_button_negative, new DialogInterface.OnClickListener() {

				@Override
				public final void onClick(final DialogInterface dialogInterface, final int which) {
					dialogInterface.dismiss();
				}

			}).setNeutralButton(R.string.dialog_lesson_button_neutral, new DialogInterface.OnClickListener() {

				@Override
				public final void onClick(final DialogInterface dialogInterface, final int which) {
					launchBrowser(LessonActivity.this, Uri.parse("https://bacomathiqu.es/a-propos/"));
				}

			}).setPositiveButton(R.string.dialog_lesson_button_positive, new DialogInterface.OnClickListener() {

				@Override
				public final void onClick(final DialogInterface dialogInterface, final int which) {
					launchBrowser(LessonActivity.this, Uri.parse("https://play.google.com/store/apps/details?id=fr.bacomathiques"));
				}

			}).show();
			return true;
		}

		return super.onOptionsItemSelected(item);
	}

	@Override
	public final void onGetLessonStarted() {
		final ActionBar actionBar = this.getSupportActionBar();
		if(actionBar != null) {
			actionBar.setTitle(R.string.activity_lesson_defaulttitle);
			actionBar.setDisplayHomeAsUpEnabled(true);
		}
		this.setRequestedOrientation(this.getRequestedOrientation());

		final WaveDrawable indeterminate = new WaveDrawable(ContextCompat.getDrawable(this, R.mipmap.ic_launcher));
		indeterminate.setIndeterminate(true);

		dialog = new ProgressDialog(this);
		dialog.setMessage(this.getString(R.string.dialog_loading_message));
		dialog.setCancelable(false);
		dialog.setOnDismissListener(new DialogInterface.OnDismissListener() {

			@Override
			public final void onDismiss(final DialogInterface dialogInterface) {
				LessonActivity.this.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_UNSPECIFIED);
			}

		});
		dialog.setIndeterminateDrawable(indeterminate);
		dialog.show();
	}

	@Override
	public final void onGetLessonException(final Exception ex, final long offlineDate) {
		ex.printStackTrace();

		if(offlineDate != -1L) {
			final Calendar calendar = Calendar.getInstance();
			calendar.setTimeInMillis(offlineDate);

			Snacky.builder()
					.setActivity(LessonActivity.this)
					.setText(LessonActivity.this.getString(R.string.snackbar_offline, SimpleDateFormat.getDateInstance().format(calendar.getTime())))
					.setDuration(Snacky.LENGTH_LONG)
					.setBackgroundColor(ContextCompat.getColor(LessonActivity.this, R.color.colorPrimaryDark))
					.info()
					.show();
		}
	}

	@Override
	public final void onGetLessonDone(final LessonContent result) {
		content = result;

		if(dialog != null && dialog.isShowing()) {
			dialog.dismiss();
		}
		dialog = null;

		if(result == null) {
			new AlertDialog.Builder(this).setTitle(R.string.dialog_generic_error).setMessage(R.string.dialog_errorgetlesson_message).setPositiveButton(R.string.dialog_generic_ok, new DialogInterface.OnClickListener() {

				@Override
				public final void onClick(final DialogInterface dialogInterface, final int id) {
					dialogInterface.dismiss();
				}

			}).setOnDismissListener(new DialogInterface.OnDismissListener() {

				@Override
				public final void onDismiss(final DialogInterface dialogInterface) {
					LessonActivity.this.onBackPressed();
				}

			}).create().show();
			return;
		}

		final Intent intent = this.getIntent();

		String content = "<!DOCTYPE HTML>";
		content += "<html>";
		content += "<head>";
		content += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>";
		content += "<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\"/>";
		content += "<script type=\"text/javascript\">const BASE_URL = \"" + LessonSummary.BASE_URL + "\"; const PAGE_ID = \"" + result.getId() + "\";</script>";
		if(intent.hasExtra(INTENT_ANCHOR)) {
			content += "<script type=\"text/javascript\">const ANCHOR = \"" + intent.getStringExtra(INTENT_ANCHOR) + "\";</script>";
		}
		content += "<script type=\"text/javascript\" src=\"script.js\"></script>";
		content += "<script type=\"text/x-mathjax-config\">MathJax.Hub.Config({tex2jax: { inlineMath: [ ['$','$'], ['\\\\(','\\\\)'] ]},'HTML-CSS': { webFont: 'TeX', preferredFont: 'TeX', availableFonts: [ 'TeX' ], extensions: ['handle-floats.js']}, messageStyle: 'none', showMathMenu: false});</script>";
		content += "<script type=\"text/javascript\" src=\"mathjax/MathJax.js?config=TeX-AMS_HTML\"></script>";
		content += "</head>";
		content += "<body>";
		content += result.getContent();
		content += "</body>";
		content += "</html>";

		final WebView webView = this.findViewById(R.id.lesson_webview);
		webView.loadDataWithBaseURL("file:///android_asset/webview/", content, "text/html", "UTF-8", null);

		final ActionBar actionBar = this.getSupportActionBar();
		if(actionBar != null) {
			final String[] title = result.getTitle().split(" - ");

			actionBar.setTitle(title[0]);
			actionBar.setSubtitle(title[1]);
		}
	}

}