package fr.bacomathiques.tasks;

import android.content.Context;
import android.os.AsyncTask;

import org.json.JSONArray;
import org.json.JSONException;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.List;

import fr.bacomathiques.lesson.LessonSummary;

public class RequestLessonsTask extends AsyncTask<String, Void, LessonSummary[]> {

	private final WeakReference<Context> context;
	private final RequestLessonsListener listener;

	public RequestLessonsTask(final Context context, final RequestLessonsListener listener) {
		this.context = new WeakReference<>(context);
		this.listener = listener;
	}

	@Override
	protected final void onPreExecute() {
		listener.onRequestLessonsStarted();
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

	public static LessonSummary[] readFromJSON(final String json) throws JSONException {
		final JSONArray lessons = new JSONArray(json);

		final List<LessonSummary> result = new ArrayList<>();
		for(int i = 0; i < lessons.length(); i++) {
			result.add(new LessonSummary(lessons.getJSONObject(i)));
		}

		return result.toArray(new LessonSummary[result.size()]);
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
			listener.onRequestLessonsException(ex, (Long)result[0]);
		}

		return lessons;
	}

	@Override
	protected final void onPostExecute(final LessonSummary[] result) {
		listener.onRequestLessonsDone(result);
	}

	public interface RequestLessonsListener {

		void onRequestLessonsStarted();
		void onRequestLessonsException(final Exception ex, final long offlineDate);
		void onRequestLessonsDone(final LessonSummary[] result);

	}

}
