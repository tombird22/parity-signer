package io.parity.signer.bottomsheets

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import io.parity.signer.alerts.AndroidCalledConfirm
import io.parity.signer.components.BigButton
import io.parity.signer.components.HeaderBar
import io.parity.signer.components.NetworkCard
import io.parity.signer.components.NetworkCardModel
import io.parity.signer.domain.SignerMainViewModel
import io.parity.signer.domain.navigate
import io.parity.signer.ui.theme.Bg000
import io.parity.signer.ui.theme.modal
import io.parity.signer.uniffi.Action
import io.parity.signer.uniffi.MManageMetadata

@Composable
fun ManageMetadata(
    networks: MManageMetadata,
    signerMainViewModel: SignerMainViewModel
) {
	var confirm by remember { mutableStateOf(false) }

	Surface(
		color = Color.Transparent,
		modifier = Modifier.clickable { signerMainViewModel.navigate(Action.GO_BACK) }
	) {
		Column {
			Spacer(Modifier.weight(1f))
			Surface(
				color = MaterialTheme.colors.Bg000,
				shape = MaterialTheme.shapes.modal
			) {
				Column(
					modifier = Modifier.padding(20.dp)
				) {
					HeaderBar(line1 = "MANAGE METADATA", line2 = "Select action")

					Row {
						Text("Used for:")
						LazyColumn {
							items(networks.networks.size) { index ->
								NetworkCard(
									network = NetworkCardModel(
										networkTitle = networks.networks[index].title,
										networkLogo = networks.networks[index].logo
									)
								)
							}
						}
					}
					BigButton(
						text = "Sign this metadata",
						isShaded = true,
						isCrypto = true,
						action = { signerMainViewModel.navigate(Action.SIGN_METADATA) })
					BigButton(
						text = "Delete this metadata",
						isShaded = true,
						isDangerous = true,
						action = {
							confirm = true
						}
					)
				}
			}
		}
	}

	AndroidCalledConfirm(
		show = confirm,
		header = "Remove metadata?",
		text = "This metadata will be removed for all networks",
		back = { confirm = false },
		forward = { signerMainViewModel.navigate(Action.REMOVE_METADATA) },
		backText = "Cancel",
		forwardText = "Remove metadata"
	)
}
