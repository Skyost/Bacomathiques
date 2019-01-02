package fr.bacomathiques.adapter;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import androidx.annotation.NonNull;

/**
 * An adapter that allows to display annals.
 */

public class AnnalsAdapter extends ArrayAdapter<String> {

	/**
	 * The annal pattern.
	 */

	private final Pattern ANNAL_PATTERN = Pattern.compile("assets/pdf/annales/(\\d{4})/([a-z\\-]+)/(.*)/");

	/**
	 * Creates a new annals adapter instance.
	 *
	 * @param context The context.
	 * @param annals The annals.
	 */

	public AnnalsAdapter(final Context context, final List<String> annals) {
		super(context, android.R.layout.select_dialog_item, annals);
	}

	@NonNull
	@Override
	public View getView(final int position, final View convertView, @NonNull final ViewGroup parent) {
		final View view = super.getView(position, convertView, parent);
		if(!(view instanceof TextView)) {
			return view;
		}

		final TextView textView = (TextView)view;
		final Matcher matcher = ANNAL_PATTERN.matcher(textView.getText());
		if(matcher.matches()) {
			textView.setText(matcher.group(2).toUpperCase() + " " + matcher.group(1) + " - " + matcher.group(3).toUpperCase());
		}
		return textView;
	}

}