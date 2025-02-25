package io.parity.signer.bottomsheets

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import io.parity.signer.components.HeaderBar
import io.parity.signer.components.NetworkCard
import io.parity.signer.components.NetworkCardModel
import io.parity.signer.ui.theme.Bg000
import io.parity.signer.ui.theme.modal
import io.parity.signer.uniffi.Action
import io.parity.signer.uniffi.MNetworkMenu

@Composable
@Deprecated("not working anymore because this logic removed from rust")
//todo dmitry reimplement locally https://github.com/paritytech/parity-signer/pull/1475/files
fun NetworkSelector(
	modalData: MNetworkMenu,
	button: (Action, String) -> Unit
) {
	val networks = modalData.networks
	Surface(
		color = Color(0x00000000),
		modifier = Modifier.clickable { button(Action.GO_BACK, "") }
	) {
		Column {
			Spacer(
				Modifier
					.weight(1f)
			)
			Text("This functionality temolorary not working, android need to implement local version as rust don't support it anymore")
			Surface(
				shape = MaterialTheme.shapes.modal,
				color = MaterialTheme.colors.Bg000,
				modifier = Modifier.weight(1f)
			) {
				Column(
					modifier = Modifier.padding(horizontal = 20.dp)
				) {
					HeaderBar(
						line1 = "NETWORK",
						line2 = "Select network",
						modifier = Modifier.padding(10.dp)
					)

					LazyColumn(
						contentPadding = PaddingValues(horizontal = 8.dp),
						verticalArrangement = Arrangement.spacedBy(10.dp)
					) {
						items(networks.size) { item ->
							Row(Modifier.clickable {
//								button(
//									Action.CHANGE_NETWORK,
//									networks[item].key
//								)
							}) {
								NetworkCard(
									network = NetworkCardModel(
										networkTitle = networks[item].title,
										networkLogo = networks[item].logo
									),
									selected = networks[item].selected
								)
							}
						}
					}
				}
			}
		}
	}
}
