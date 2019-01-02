package fr.bacomathiques.activity;

import android.content.Context;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.os.Handler;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;

import com.bumptech.glide.Glide;
import com.google.android.gms.ads.MobileAds;
import com.kobakei.ratethisapp.RateThisApp;

import java.lang.ref.WeakReference;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import de.mateware.snacky.Snacky;
import fr.bacomathiques.R;
import fr.bacomathiques.adapter.LessonsSummaryAdapter;
import fr.bacomathiques.lesson.LessonSummary;
import fr.bacomathiques.task.GetSummariesTask;

/**
 * The application main activity.
 */

public class MainActivity extends AppCompatActivity implements GetSummariesTask.RequestLessonsListener {

	/**
	 * Lesson intent.
	 */

	protected static final String INTENT_LESSON = "lesson";

	/**
	 * Lessons intent.
	 */

	private static final String INTENT_LESSONS = "lessons";

	/**
	 * The current adapter.
	 */

	private LessonsSummaryAdapter adapter;

	/**
	 * The current clicked caption.
	 */

	private View clickedCaption;

	/**
	 * The offline check date.
	 */

	private long offlineDate = -1L;

	@Override
	protected void onCreate(final Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		if(savedInstanceState != null && savedInstanceState.containsKey(INTENT_LESSONS)) {
			onGetSummariesDone((LessonSummary[])GetSummariesTask.readLocalLessons(new WeakReference<>(this))[1]);
			return;
		}

		displaySplashScreen();
		MobileAds.initialize(this, getString(R.string.ADMOB_APP_ID));
		new GetSummariesTask(this, this).execute(LessonSummary.getLessonsURL());
	}

	@Override
	public void onSaveInstanceState(final Bundle outState) {
		if(adapter != null) {
			outState.putBoolean(INTENT_LESSONS, true);
		}

		super.onSaveInstanceState(outState);
	}

	@Override
	public void onGetSummariesStarted() {}

	@Override
	public void onGetSummariesException(final Exception ex, final long offlineDate) {
		ex.printStackTrace();

		this.offlineDate = offlineDate;
	}

	@Override
	public void onGetSummariesDone(final LessonSummary[] result) {
		if(isChangingConfigurations() || isFinishing()) {
			return;
		}

		if(result != null) {
			adapter = new LessonsSummaryAdapter(Glide.with(this), getResources().getInteger(R.integer.main_lessons_recyclerview_columns), result);
			hideSplashScreen();
			return;
		}
		setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
		new AlertDialog.Builder(this)
				.setTitle(R.string.dialog_generic_error)
				.setMessage(R.string.dialog_errorrequestlessons_message)
				.setPositiveButton(android.R.string.ok, null)
				.setOnDismissListener(dialogInterface -> finish())
				.show();
	}

	/**
	 * Displays the splash screen.
	 */

	public void displaySplashScreen() {
		final ActionBar actionBar = getSupportActionBar();
		if(actionBar != null) {
			actionBar.hide();

			customizeActionBar();
		}

		setContentView(R.layout.activity_main_splash);

		RateThisApp.init(new RateThisApp.Config(3, 10));
		RateThisApp.onCreate(this);
		RateThisApp.showRateDialogIfNeeded(this);
	}

	/**
	 * Hides the splash screen.
	 */

	public void hideSplashScreen() {
		final RelativeLayout layout = findViewById(R.id.splash_layout);
		if(layout == null) {
			setContentView(R.layout.activity_main);
			setupRecyclerView();
			customizeActionBar();
			return;
		}

		layout.animate().alpha(0f).setDuration(700L).withEndAction(() -> {
			final ActionBar actionBar = getSupportActionBar();
			if(actionBar != null) {
				actionBar.show();
			}

			setContentView(R.layout.activity_main);
			setupRecyclerView();

			if(offlineDate != -1L) {
				final Calendar calendar = Calendar.getInstance();
				calendar.setTimeInMillis(offlineDate);

				new Handler().postDelayed(() -> Snacky.builder()
						.setActivity(this)
						.setText(getString(R.string.snackbar_offline, SimpleDateFormat.getDateInstance().format(calendar.getTime())))
						.setDuration(Snacky.LENGTH_LONG)
						.setBackgroundColor(ContextCompat.getColor(this, R.color.colorPrimaryDark))
						.info()
						.show(), 500);
			}
		}).start();
	}

	/**
	 * On preview click event.
	 *
	 * @param view The preview view.
	 */

	public void onPreviewClick(View view) {
		if(view instanceof ImageView) {
			view = ((View)view.getParent()).findViewById(R.id.main_lessons_recyclerview_item_caption);
		}

		if(clickedCaption != null) {
			clickedCaption.animate().setDuration(300L).alpha(0f).start();

			if(view == clickedCaption) {
				clickedCaption = null;
				return;
			}
		}

		if(view.getAlpha() == 0f) {
			view.animate().setDuration(300L).alpha(1f).start();
			clickedCaption = view;
		}
		else {
			view.animate().setDuration(300L).alpha(0f).start();
			clickedCaption = null;
		}
	}

	/**
	 * On check out click event.
	 *
	 * @param view The check out view.
	 */

	public void onCheckOutClick(final View view) {
		final Intent intent = new Intent(this, LessonActivity.class);
		intent.putExtra(INTENT_LESSON, view.getTag().toString());
		startActivity(intent);
	}

	/**
	 * Setups the layout's recycler view.
	 */

	private void setupRecyclerView() {
		final RecyclerView recyclerView = findViewById(R.id.main_lessons_recyclerview);

		recyclerView.setOnTouchListener((view, motionEvent) -> {
			if(clickedCaption != null) {
				onPreviewClick(clickedCaption);
				return true;
			}
			return false;
		});

		final int columns = adapter.getColumnsNumber();
		recyclerView.setLayoutManager(columns == 1 ? new LinearLayoutManager(this) : new GridLayoutManager(this, columns));
		recyclerView.setAdapter(adapter);
	}

	/**
	 * Handles ActionBar customizations.
	 */

	private void customizeActionBar() {
		final ActionBar actionBar = getSupportActionBar();
		if(actionBar == null) {
			return;
		}

		actionBar.setDisplayOptions(ActionBar.DISPLAY_SHOW_CUSTOM);
		final LayoutInflater inflater = (LayoutInflater)getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		if(inflater != null) {
			actionBar.setCustomView(inflater.inflate(R.layout.actionbar_view, null));
		}
	}

}