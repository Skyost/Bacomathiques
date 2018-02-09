package fr.bacomathiques.activities;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.MotionEvent;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;

import com.bumptech.glide.Glide;

import fr.bacomathiques.R;
import fr.bacomathiques.adapters.LessonsAdapter;
import fr.bacomathiques.lesson.Lesson;
import fr.bacomathiques.tasks.RequestLessonsTask;
import uk.co.chrisjenx.calligraphy.CalligraphyConfig;
import uk.co.chrisjenx.calligraphy.CalligraphyContextWrapper;

public class MainActivity extends AppCompatActivity implements RequestLessonsTask.RequestLessonsListener {

	protected static final String INTENT_LESSON = "lesson";
	private static final String INTENT_LESSONS = "lessons";

	private LessonsAdapter adapter;
	private View clickedCaption;

	@Override
	protected void onCreate(final Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		if(savedInstanceState != null) {
			onRequestLessonsDone((Lesson[])savedInstanceState.getParcelableArray(INTENT_LESSONS));
			return;
		}

		displaySplashScreen();
		CalligraphyConfig.initDefault(null);
		new RequestLessonsTask(this).execute(Lesson.getLessonsURL());
	}

	@Override
	public final void onSaveInstanceState(final Bundle outState) {
		if(adapter != null) {
			outState.putParcelableArray(INTENT_LESSONS, adapter.getData());
		}

		super.onSaveInstanceState(outState);
	}

	@Override
	protected final void attachBaseContext(final Context newBase) {
		super.attachBaseContext(CalligraphyContextWrapper.wrap(newBase));
	}

	@Override
	public final void onRequestLessonsStarted() {}

	@Override
	public final void onRequestLessonsException(final Exception ex) {
		ex.printStackTrace();
	}

	@Override
	public final void onRequestLessonsDone(final Lesson[] result) {
		if(result != null) {
			adapter = new LessonsAdapter(Glide.with(this), result);
			hideSplashScreen();
			return;
		}
		this.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
		new AlertDialog.Builder(this).setTitle(R.string.dialog_generic_error).setMessage(R.string.dialog_errorrequestlessons_message).setPositiveButton(R.string.dialog_generic_ok, new DialogInterface.OnClickListener() {

			@Override
			public final void onClick(final DialogInterface dialogInterface, final int id) {
				dialogInterface.dismiss();
			}

		}).setOnDismissListener(new DialogInterface.OnDismissListener() {

			@Override
			public final void onDismiss(final DialogInterface dialogInterface) {
				MainActivity.this.finish();
			}

		}).create().show();
	}

	/**
	 * Displays the splash screen.
	 */

	public final void displaySplashScreen() {
		this.setContentView(R.layout.activity_main_splash);
	}

	/**
	 * Hides the splash screen.
	 */

	public final void hideSplashScreen() {
		final RelativeLayout layout = this.findViewById(R.id.splash_layout);
		if(layout == null) {
			MainActivity.this.setContentView(R.layout.activity_main);
			setupRecyclerView();
			return;
		}

		layout.animate().alpha(0f).withEndAction(new Runnable() {

			@Override
			public final void run() {
				MainActivity.this.setContentView(R.layout.activity_main);
				setupRecyclerView();
			}

		}).start();
	}

	/**
	 * On preview click event.
	 *
	 * @param view The preview view.
	 */

	public final void onPreviewClick(View view) {
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

	public final void onCheckOutClick(final View view) {
		final Intent intent = new Intent(this, LessonActivity.class);
		intent.putExtra(INTENT_LESSON, view.getTag().toString());
		this.startActivity(intent);
	}

	/**
	 * Setups the layout's recycler view.
	 */

	private void setupRecyclerView() {
		final RecyclerView recyclerView = this.findViewById(R.id.main_lessons_recyclerview);

		recyclerView.setOnTouchListener(new View.OnTouchListener() {

			@Override
			public final boolean onTouch(final View view, final MotionEvent motionEvent) {
				if(clickedCaption != null) {
					onPreviewClick(clickedCaption);
					return true;
				}
				return false;
			}

		});

		final int columns = this.getResources().getInteger(R.integer.main_lessons_recyclerview_columns);
		recyclerView.setLayoutManager(columns == 1 ? new LinearLayoutManager(this) : new GridLayoutManager(this, columns));
		recyclerView.setAdapter(adapter);
	}

}