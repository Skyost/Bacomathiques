package fr.bacomathiques.tasks;

import android.content.Context;
import android.net.ConnectivityManager;
import android.os.AsyncTask;

import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.Closeable;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.ref.WeakReference;
import java.net.HttpURLConnection;
import java.net.URL;

import fr.bacomathiques.lesson.LessonContent;

public class GetLessonTask extends AsyncTask<String, Void, LessonContent> {

	private final WeakReference<Context> context;
	private final GetLessonListener listener;

	public GetLessonTask(final Context context, final GetLessonListener listener) {
		this.context = new WeakReference<>(context);
		this.listener = listener;
	}

	/**
	 * Reads a line from a given url and caches it to a local file.
	 *
	 * @param contextReference A context reference (used to save the line to a file).
	 * @param url The url.
	 *
	 * @return The line.
	 *
	 * @throws IOException If any error occurs.
	 */

	static String readRemoteLine(final WeakReference<Context> contextReference, final String url) throws IOException {
		final Context context = contextReference.get();
		if(context == null) {
			return null;
		}

		final ConnectivityManager connectivityManager = (ConnectivityManager)context.getSystemService(Context.CONNECTIVITY_SERVICE);
		if(connectivityManager == null) {
			throw new IOException("Can't check for connectivity.");
		}

		if(!connectivityManager.getNetworkInfo(ConnectivityManager.TYPE_WIFI).isConnectedOrConnecting() && !connectivityManager.getNetworkInfo(ConnectivityManager.TYPE_MOBILE).isConnectedOrConnecting()) {
			throw new IOException("No connection available.");
		}

		final HttpURLConnection connection = (HttpURLConnection)new URL(url).openConnection();
		connection.setConnectTimeout(10 * 1000);
		connection.setReadTimeout(10 * 1000);

		final String line = readLineFromInputStream(connection.getInputStream());

		FileOutputStream fileOutputStream = null;
		try {
			fileOutputStream = context.openFileOutput(url.substring(url.lastIndexOf("/") + 1), Context.MODE_PRIVATE);
			fileOutputStream.write(line.getBytes("UTF-8"));
		}
		catch(final Exception ex) {
			ex.printStackTrace();
		}
		finally {
			if(fileOutputStream != null) {
				fileOutputStream.close();
			}
		}

		return line;
	}

	/**
	 * Reads a local file.
	 *
	 * @param contextReference A context reference (used to read the file).
	 * @param url The remote URL.
	 *
	 * @return 0 : The local file last modification date, 1 : The local file content.
	 */

	static Object[] readLocalFile(final WeakReference<Context> contextReference, final String url) {
		try {
			final Context context = contextReference.get();
			if(context == null) {
				return null;
			}

			final String path = url.substring(url.lastIndexOf("/") + 1);
			return new Object[]{context.getFileStreamPath(path).lastModified(), readLineFromInputStream(context.openFileInput(path))};
		}
		catch(final Exception ex) {
			ex.printStackTrace();
		}

		return null;
	}

	/**
	 * Reads a line from an input stream.
	 *
	 * @param inputStream The input stream.
	 * @return The line.
	 *
	 * @throws IOException If any exception occurs while reading the line.
	 */

	private static String readLineFromInputStream(final InputStream inputStream) throws IOException {
		InputStreamReader inputStreamReader = null;
		BufferedReader bufferedReader = null;

		try {
			inputStreamReader = new InputStreamReader(inputStream, "UTF-8");
			bufferedReader = new BufferedReader(inputStreamReader);

			return bufferedReader.readLine();
		}
		finally {
			for(final Closeable closeable : new Closeable[]{inputStream, inputStreamReader, bufferedReader}) {
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
	}

	@Override
	protected final void onPreExecute() {
		listener.onGetLessonStarted();
	}

	@Override
	protected final LessonContent doInBackground(final String... params) {
		LessonContent content = null;

		try {
			content = new LessonContent(new JSONObject(readRemoteLine(context, params[0])));
		}
		catch(final Exception remoteEx) {
			long offlineDate = -1L;

			try {
				final Object[] data = readLocalFile(context, params[0]);

				offlineDate = (long)data[0];
				content = new LessonContent(new JSONObject((String)data[1]));
			}
			catch(Exception localEx) {
				localEx.printStackTrace();
			}

			listener.onGetLessonException(remoteEx, offlineDate);
		}

		return content;
	}

	@Override
	protected final void onPostExecute(final LessonContent result) {
		listener.onGetLessonDone(result);
	}

	public interface GetLessonListener {

		void onGetLessonStarted();
		void onGetLessonException(final Exception ex, final long offlineDate);
		void onGetLessonDone(final LessonContent result);

	}

}
