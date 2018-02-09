package fr.bacomathiques.tasks;

import android.os.AsyncTask;

import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.Closeable;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import fr.bacomathiques.lesson.LessonContent;

public class GetLessonTask extends AsyncTask<String, Void, LessonContent> {

	private final GetLessonListener listener;

	public GetLessonTask(final GetLessonListener listener) {
		this.listener = listener;
	}

	/**
	 * Reads a line from a given url.
	 *
	 * @param url The url.
	 *
	 * @return The line.
	 *
	 * @throws Exception If any error occurs.
	 */

	static String readLine(final String url) throws Exception {
		InputStream input = null;
		InputStreamReader inputStreamReader = null;
		BufferedReader bufferedReader = null;

		String line;

		try {
			final HttpURLConnection connection = (HttpURLConnection)new URL(url).openConnection();
			connection.setConnectTimeout(10 * 1000);
			connection.setReadTimeout(10 * 1000);

			final String response = connection.getResponseCode() + " " + connection.getResponseMessage();

			input = response.startsWith("2") ? connection.getInputStream() : connection.getErrorStream();
			inputStreamReader = new InputStreamReader(input, "UTF-8");
			bufferedReader = new BufferedReader(inputStreamReader);

			line = bufferedReader.readLine();
		}
		finally {
			for(final Closeable closeable : new Closeable[]{input, inputStreamReader, bufferedReader}) {
				try {
					if(closeable != null) {
						closeable.close();
					}
				}
				catch(final Exception ex) {
					ex.printStackTrace();
				}
			}
		}

		return line;
	}

	@Override
	protected final void onPreExecute() {
		listener.onGetLessonStarted();
	}

	@Override
	protected final LessonContent doInBackground(final String... params) {
		try {
			final JSONObject lesson = new JSONObject(readLine(params[0]));
			return new LessonContent(lesson);
		}
		catch(final Exception ex) {
			listener.onGetLessonException(ex);
		}
		return null;
	}

	@Override
	protected final void onPostExecute(final LessonContent result) {
		listener.onGetLessonDone(result);
	}

	public interface GetLessonListener {

		void onGetLessonStarted();

		void onGetLessonException(final Exception ex);

		void onGetLessonDone(final LessonContent result);

	}

}
