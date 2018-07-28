package fr.bacomathiques.task;

import android.content.Context;
import android.os.AsyncTask;

import org.json.JSONArray;
import org.json.JSONException;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.List;

import fr.bacomathiques.lesson.LessonSummary;

/**
 * The task that allows to get all available summaries.
 */

public class GetSummariesTask extends AsyncTask<String, Void, LessonSummary[]> {

	/**
	 * A context reference.
	 */

	private final WeakReference<Context> context;

	/**
	 * The listener.
	 */

	private final RequestLessonsListener listener;

	/**
	 * Creates a new get summaries task instance.
	 *
	 * @param context The context.
	 * @param listener The listener.
	 */

	public GetSummariesTask(final Context context, final RequestLessonsListener listener) {
		this.context = new WeakReference<>(context);
		this.listener = listener;
	}

	/**
	 * Reads a JSONArray from a string.
	 *
	 * @param json The string.
	 *
	 * @return The JSONArray.
	 *
	 * @throws JSONException If a JSON exception occurs.
	 */

	private static LessonSummary[] readFromJSON(final String json) throws JSONException {
		final JSONArray lessons = new JSONArray(json);

		final List<LessonSummary> result = new ArrayList<>();
		for(int i = 0; i < lessons.length(); i++) {
			result.add(new LessonSummary(lessons.getJSONObject(i)));
		}

		return result.toArray(new LessonSummary[result.size()]);
	}

	@Override
	protected final void onPreExecute() {
		listener.onGetSummariesStarted();
	}

	/**
	 * Reads local lessons.
	 *
	 * @param context The context.
	 *
	 * @return 0 : The local file last modification date, 1 : The local lessons summary.
	 */

	public static Object[] readLocalLessons(final WeakReference<Context> context) {
		long offlineDate = -1L;

		try {
			final Object[] data = GetLessonTask.readLocalFile(context, LessonSummary.getLessonsURL());

			offlineDate = (long)data[0];
			final LessonSummary[] lessons = readFromJSON((String)data[1]);

			return new Object[]{offlineDate, lessons};
		}
		catch(final Exception ex) {
			ex.printStackTrace();
		}

		return new Object[]{offlineDate, null};
	}

	@Override
	protected final LessonSummary[] doInBackground(final String... params) {
		final String url = params[0];
		LessonSummary[] lessons;

		try {
			lessons = readFromJSON(GetLessonTask.readRemoteLine(context, url));
		}
		catch(final Exception ex) {
			final Object[] result = readLocalLessons(context);
			lessons = (LessonSummary[])result[1];
			listener.onGetSummariesException(ex, (Long)result[0]);
		}

		return lessons;
	}

	@Override
	protected final void onPostExecute(final LessonSummary[] result) {
		listener.onGetSummariesDone(result);
	}

	/**
	 * The listener interface.
	 */

	public interface RequestLessonsListener {

		/**
		 * Triggered when the task starts to get the summaries.
		 */

		void onGetSummariesStarted();

		/**
		 * Triggered when an exception occurs.
		 *
		 * @param ex The exception.
		 * @param offlineDate The offline content date.
		 */

		void onGetSummariesException(final Exception ex, final long offlineDate);

		/**
		 * Triggered when task has found summaries.
		 *
		 * @param result All summaries.
		 */

		void onGetSummariesDone(final LessonSummary[] result);

	}

}
