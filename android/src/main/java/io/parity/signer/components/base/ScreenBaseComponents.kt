package io.parity.signer.components.base

import android.content.res.Configuration
import androidx.compose.foundation.Image
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ChevronLeft
import androidx.compose.material.icons.filled.Close
import androidx.compose.material.icons.filled.HelpOutline
import androidx.compose.material.icons.filled.MoreHoriz
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.ColorFilter
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import io.parity.signer.R
import io.parity.signer.domain.Callback
import io.parity.signer.ui.theme.SignerNewTheme
import io.parity.signer.ui.theme.SignerTypeface
import io.parity.signer.ui.theme.textTertiary


@Composable
fun ScreenHeader(
	title: String?,
	onBack: (() -> Unit)? = null,
	onMenu: (() -> Unit)? = null,
) {
	Row(
		modifier = Modifier
			.fillMaxWidth(1f)
			.defaultMinSize(minHeight = 56.dp)
	) {
		if (onBack != null) {
			Image(
				imageVector = Icons.Filled.ChevronLeft,
				contentDescription = stringResource(R.string.description_back_button),
				colorFilter = ColorFilter.tint(MaterialTheme.colors.primary),
				modifier = Modifier
					.padding(horizontal = 8.dp)
					.clickable(onClick = onBack)
					.padding(8.dp)
					.size(24.dp)
					.align(Alignment.CenterVertically)
			)
		} else {
			Spacer(modifier = Modifier.padding(start = 44.dp))
		}
		//center
		if (title != null) {
			Text(
				text = title,
				color = MaterialTheme.colors.primary,
				style = SignerTypeface.TitleS,
				textAlign = TextAlign.Center,
				modifier = Modifier
					.align(Alignment.CenterVertically)
					.weight(1f)
			)
		} else {
			Spacer(modifier = Modifier.weight(1f))
		}
		//end
		if (onMenu != null) {
			Image(
				imageVector = Icons.Filled.MoreHoriz,
				contentDescription = stringResource(R.string.description_menu_button),
				colorFilter = ColorFilter.tint(MaterialTheme.colors.primary),
				modifier = Modifier
					.padding(horizontal = 8.dp)
					.clickable(onClick = onMenu)
					.padding(8.dp)
					.size(24.dp)
					.align(Alignment.CenterVertically)
			)
		} else {
			Spacer(modifier = Modifier.padding(start = 44.dp))
		}
	}
}

@Composable
fun ScreenHeaderClose(
	title: String,
	subtitle: String? = null,
	onClose: () -> Unit,
	onMenu: (() -> Unit)? = null,
	differentMenuIcon: ImageVector? = null,
) {
	Row(
		modifier = Modifier
			.fillMaxWidth(1f)
			.defaultMinSize(minHeight = 56.dp)
	) {
		Image(
			imageVector = Icons.Filled.Close,
			contentDescription = stringResource(R.string.description_back_button),
			colorFilter = ColorFilter.tint(MaterialTheme.colors.primary),
			modifier = Modifier
				.padding(horizontal = 8.dp)
				.clickable(onClick = onClose)
				.padding(8.dp)
				.size(24.dp)
				.align(Alignment.CenterVertically)
		)
		//center
		Column(
			modifier = Modifier
				.align(Alignment.CenterVertically)
				.weight(1f)
		) {
			Text(
				text = title,
				color = MaterialTheme.colors.primary,
				style = SignerTypeface.TitleS,
				textAlign = TextAlign.Center,
				modifier = Modifier.fillMaxWidth(1f),
			)
			if (subtitle != null) {
				Text(
					text = subtitle,
					color = MaterialTheme.colors.textTertiary,
					style = SignerTypeface.CaptionM,
					textAlign = TextAlign.Center,
					modifier = Modifier.fillMaxWidth(1f),
				)
			}
		}
		//end
		if (onMenu != null) {
			Image(
				imageVector = differentMenuIcon ?: Icons.Filled.MoreHoriz,
				contentDescription = stringResource(R.string.description_menu_button),
				colorFilter = ColorFilter.tint(MaterialTheme.colors.primary),
				modifier = Modifier
					.padding(horizontal = 8.dp)
					.clickable(onClick = onMenu)
					.padding(8.dp)
					.size(24.dp)
					.align(Alignment.CenterVertically)
			)
		} else {
			Spacer(modifier = Modifier.padding(start = 44.dp))
		}
	}
}


//todo dmitry DerivationPathScreen.kt:350 migrate to this view when merged
@Composable
fun ScreenHeaderWithButton(
	canProceed: Boolean,
	title: String = "",
	onClose: Callback,
	onDone: Callback,
) {
	Box(
		modifier = Modifier.padding(
			start = 24.dp,
			end = 8.dp,
			top = 8.dp,
			bottom = 8.dp
		),
		contentAlignment = Alignment.Center,
	) {
		Box(
			modifier = Modifier.fillMaxWidth(1f),
			contentAlignment = Alignment.CenterStart,
		) {
			CloseIcon(
				noBackground = true,
				onCloseClicked = onClose,
			)
		}
		Box(
			modifier = Modifier.fillMaxWidth(1f),
			contentAlignment = Alignment.Center,
		) {
			Text(
				text = title,
				color = MaterialTheme.colors.primary,
				style = SignerTypeface.TitleS,
				textAlign = TextAlign.Center,
				modifier = Modifier.fillMaxWidth(1f)
			)
		}
		Box(
			modifier = Modifier.fillMaxWidth(1f),
			contentAlignment = Alignment.CenterEnd,
		) {
			PrimaryButtonGreyDisabled(
				label = stringResource(R.string.generic_done),
				isEnabled = canProceed,
			) {
				if (canProceed) {
					onDone()
				}
			}
		}
	}
}


@Preview(
	name = "day",
	group = "themes",
	uiMode = Configuration.UI_MODE_NIGHT_NO,
	showBackground = true,
	backgroundColor = 0xFFFFFFFF
)
@Preview(
	name = "dark theme",
	group = "themes",
	uiMode = Configuration.UI_MODE_NIGHT_YES,
	showBackground = true,
	backgroundColor = 0xFF000000
)
@Composable
private fun PreviewScreenBaseComponent() {
	SignerNewTheme() {
		Column(
			modifier = Modifier.size(500.dp),
		) {
			ScreenHeader(
				null,
				onBack = {},
				onMenu = {},
			)
			ScreenHeader(
				stringResource(R.string.key_sets_screem_title),
				onBack = null,
				onMenu = {},
			)
			ScreenHeader(
				stringResource(id = R.string.key_sets_screem_title),
				onBack = null,
				onMenu = null,
			)
			ScreenHeaderClose(
				stringResource(id = R.string.key_sets_screem_title),
				onClose = {},
				onMenu = null,
			)
			ScreenHeaderClose(
				stringResource(id = R.string.key_sets_screem_title),
				"subtitle",
				onClose = {},
				onMenu = {},
			)
			ScreenHeaderWithButton(true, "Derivation", {}, {})
			ScreenHeaderWithButton(false, "Derivation", {}, {})
			ScreenHeaderClose(
				stringResource(id = R.string.key_sets_screem_title),
				onClose = {},
				onMenu = {},
				differentMenuIcon = Icons.Filled.HelpOutline,
			)
		}
	}
}
