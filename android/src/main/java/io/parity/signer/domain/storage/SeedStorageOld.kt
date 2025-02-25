package io.parity.signer.domain.storage

import android.util.Log
import android.widget.Toast
import androidx.lifecycle.viewModelScope
import io.parity.signer.dependencygraph.ServiceLocator
import io.parity.signer.domain.SignerMainViewModel
import io.parity.signer.uniffi.Action
import io.parity.signer.uniffi.updateSeedNames
import kotlinx.coroutines.*

/**
 * Refresh seed names list
 * should be called within authentication envelope
 * authentication.authenticate(activity) {refreshSeedNames()}
 * which is somewhat asynchronous
 */
internal fun SignerMainViewModel.tellRustSeedNames() {
	val allNames = seedStorage.getSeedNames()
	updateSeedNames(allNames.toList())
}

/**
 * Add seed, encrypt it, and create default accounts
 *
 * @param createRoots is fake and should always be true. It's added for educational reasons
 */
@Deprecated("Use SeedRepository directly")
fun SignerMainViewModel.addSeed(
	seedName: String,
	seedPhrase: String,
) {
	viewModelScope.launch {
		val repository = ServiceLocator.activityScope!!.seedRepository
		repository.addSeed(
			seedName = seedName,
			seedPhrase = seedPhrase,
			navigator = navigator,
			isOptionalAuth = false
		)
	}
}

/**
 * Fetch seed from strongbox; must be in unlocked scope
 */
@Deprecated("Use SeedStorage or better SeedRepository")
internal fun SignerMainViewModel.getSeed(
	seedName: String,
	backup: Boolean = false
): String {
	return try {
		seedStorage.getSeed(seedName, backup)
	} catch (e: java.lang.Exception) {
		Log.d("get seed failure", e.toString())
		Toast.makeText(context, "get seed failure: $e", Toast.LENGTH_LONG).show()
		""
	}
}

/**
 * All logic required to remove seed from memory
 *
 * 1. Remover encrypted storage item
 * 2. Synchronizes list of seeds with rust
 * 3. Calls rust remove seed logic
 */
@Deprecated("Use SeedStorage or better SeedRepository")
fun SignerMainViewModel.removeSeed(seedName: String) {
	ServiceLocator.authentication.authenticate(activity) {
		try {
			seedStorage.removeSeed(seedName)
			tellRustSeedNames()
			navigator.navigate(Action.REMOVE_SEED)
		} catch (e: java.lang.Exception) {
			Log.d("remove seed error", e.toString())
			Toast.makeText(context, e.toString(), Toast.LENGTH_SHORT).show()
		}
	}
}

