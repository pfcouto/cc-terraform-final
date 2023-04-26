<script lang="ts">
	import { Label, Input, Select, Button, Alert } from 'flowbite-svelte';

	let currency = '';
	let owner = '';
	let showingAlert = false;
	let isSuccess = false;

	let countries = [
		{ value: 'USD', name: 'Dólar' },
		{ value: 'EUR', name: 'Euro' }
	];
	async function handleSubmit(event) {
		event.preventDefault();

		const data = { owner, currency };

		try {
			const response = await fetch(`${import.meta.env.VITE_Golang_API_URL || 'http://localhost:8080'}/accounts`, {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify(data)
			});

			if (response.ok) {
				isSuccess = true;
			} else {
				isSuccess = false;
				throw new Error(`HTTP error! status: ${response.status}`);
			}

			showingAlert = true;

			setTimeout(() => {
				showingAlert = false;
			}, 4000);

			// const result = await response.json();
			// console.log(result);
		} catch (error) {
			showingAlert = true;
			isSuccess = false;
			setTimeout(() => {
				showingAlert = false;
			}, 4000);
		}
	}
</script>

<div class="mt-5 pl-20">
	<span class="text-xl font-semibold dark:text-white"> Create Account </span>
</div>

<div class="grid place-items-center">
	<div class="py-10 px-20 w-1/2">
		<form on:submit={handleSubmit}>
			<div class="mb-6">
				<Label for="default-input" class="block mb-2">Owner</Label>
				<Input id="default-input" placeholder="Default input" bind:value={owner} />
			</div>

			<Label
				>Select an option
				<Select class="mt-2" items={countries} bind:value={currency} />
			</Label>
			<Button color="light" class="mt-8" type="Submit">Submit</Button>
		</form>
	</div>

	{#if showingAlert}
		{#if isSuccess}
			<Alert color="green" class="alert {showingAlert ? 'show' : 'hidden'}">
				<span slot="icon"
					><svg
						aria-hidden="true"
						class="w-5 h-5"
						fill="currentColor"
						viewBox="0 0 20 20"
						xmlns="http://www.w3.org/2000/svg"
						><path
							fill-rule="evenodd"
							d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z"
							clip-rule="evenodd"
						/></svg
					>
				</span>
				<span class="font-medium">Success!</span> A new account has been created.
			</Alert>
		{:else}
			<div class="alert {showingAlert ? 'show' : 'hidden'}">
				<Alert color="red">
					<span slot="icon"
						><svg
							aria-hidden="true"
							class="w-5 h-5"
							fill="currentColor"
							viewBox="0 0 20 20"
							xmlns="http://www.w3.org/2000/svg"
							><path
								fill-rule="evenodd"
								d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z"
								clip-rule="evenodd"
							/></svg
						>
					</span>
					<span class="font-medium">Error!</span> Something wrong ain't right.
				</Alert>
			</div>
		{/if}
	{/if}
</div>

<style>
	.alert {
		opacity: 0;
		max-height: 0;
	}

	.alert.show {
		opacity: 1;
		max-height: 1000px;
		transition: all 250ms linear;
	}
	.alert.hidden {
		opacity: 1;
		max-height: 1000px;
		transition: all 250ms linear;
	}
</style>
