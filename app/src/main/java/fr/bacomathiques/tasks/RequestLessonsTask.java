package fr.bacomathiques.tasks;

import android.os.AsyncTask;

import org.json.JSONArray;

import java.util.ArrayList;
import java.util.List;

import fr.bacomathiques.lesson.Lesson;

public class RequestLessonsTask extends AsyncTask<String, Void, Lesson[]> {

	private final RequestLessonsListener listener;

	public RequestLessonsTask(final RequestLessonsListener listener) {
		this.listener = listener;
	}

	@Override
	protected final void onPreExecute() {
		listener.onRequestLessonsStarted();
	}

	@Override
	protected final Lesson[] doInBackground(final String... params) {
		try {
			final JSONArray lessons = new JSONArray(GetLessonTask.readLine(params[0]));

			final List<Lesson> result = new ArrayList<>();
			for(int i = 0; i < lessons.length(); i++) {
				result.add(new Lesson(lessons.getJSONObject(i)));
			}

			return result.toArray(new Lesson[result.size()]);
		}
		catch(final Exception ex) {
			listener.onRequestLessonsException(ex);
		}
		return null;
	}

	@Override
	protected final void onPostExecute(final Lesson[] result) {
		listener.onRequestLessonsDone(result);
	}

	public interface RequestLessonsListener {

		void onRequestLessonsStarted();

		void onRequestLessonsException(final Exception ex);

		void onRequestLessonsDone(final Lesson[] result);

	}

}
