package io.parity.signer.screens.keysets

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.runtime.Composable
import androidx.compose.runtime.State
import androidx.compose.ui.Modifier
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import io.parity.signer.domain.NetworkState
import io.parity.signer.domain.KeySetsSelectModel
import io.parity.signer.domain.Navigator
import io.parity.signer.screens.keysets.export.KeySetsExportScreenFull
import io.parity.signer.ui.BottomSheetWrapperRoot

/**
 * Navigation Subgraph with compose nav controller for those Key Set screens which are not part of general
 * Rust-controlled navigation
 */
@Composable
fun KeySetsNavSubgraph(
	model: KeySetsSelectModel,
	rootNavigator: Navigator,
	networkState: State<NetworkState?>, //for shield icon
) {
	val navController = rememberNavController()
	NavHost(
		navController = navController,
		startDestination = KeySetsNavSubgraph.home,
	) {

		composable(KeySetsNavSubgraph.home) {
			Box(modifier = Modifier.statusBarsPadding()) {
				KeySetsScreen(
					model = model,
					rootNavigator = rootNavigator,
					localNavigator = navController,
					networkState = networkState,
				)
			}
		}
		composable(KeySetsNavSubgraph.homeMenu) {
			Box(modifier = Modifier.statusBarsPadding()) {
				KeySetsScreen(
					model = model,
					rootNavigator = rootNavigator,
					localNavigator = navController,
					networkState = networkState,
				)
			}
			BottomSheetWrapperRoot(onClosedAction = {
				navController.navigate(
					KeySetsNavSubgraph.home
				)
			}) {
				KeySetsMenuBottomSheet(navigator = navController)
			}
		}
		composable(KeySetsNavSubgraph.export) {
			KeySetsExportScreenFull(
				model = model,
				onClose = { navController.navigate(KeySetsNavSubgraph.home) },
			)
		}
	}
}


internal object KeySetsNavSubgraph {
	const val home = "keysets_home"
	const val homeMenu = "keysets_menu"
	const val export = "keysets_export"
}
