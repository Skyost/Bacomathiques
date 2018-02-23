package fr.bacomathiques.tasks;

import android.content.Context;
import android.os.AsyncTask;

import org.json.JSONArray;
import org.json.JSONException;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.List;

import fr.bacomathiques.lesson.Lesson;

public class RequestLessonsTask extends AsyncTask<String, Void, Lesson[]> {

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

	@Override
	protected final Lesson[] doInBackground(final String... params) {
		Lesson[] lessons = null;

		try {
			lessons = readFromJSON(GetLessonTask.readRemoteLine(context, params[0]));
		}
		catch(final Exception ex) {
			long offlineDate = -1L;

			try {
				final Object[] data = GetLessonTask.readLocalFile(context, params[0]);

				offlineDate = (long)data[0];
				lessons = readFromJSON((String)data[1]);
			}
			catch(Exception localEx) {
				localEx.printStackTrace();
			}

			listener.onRequestLessonsException(ex, offlineDate);
		}

		return lessons;
	}

	@Override
	protected final void onPostExecute(final Lesson[] result) {
		listener.onRequestLessonsDone(result);
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

	private Lesson[] readFromJSON(final String json) throws JSONException {
		final JSONArray lessons = new JSONArray(json);

		final List<Lesson> result = new ArrayList<>();
		for(int i = 0; i < lessons.length(); i++) {
			result.add(new Lesson(lessons.getJSONObject(i)));
		}

		return result.toArray(new Lesson[result.size()]);
	}

	public interface RequestLessonsListener {

		void onRequestLessonsStarted();
		void onRequestLessonsException(final Exception ex, final long offlineDate);
		void onRequestLessonsDone(final Lesson[] result);

	}

}
