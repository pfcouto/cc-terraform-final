<script>
	import { Card } from 'flowbite-svelte';

	/** @type {import('./$types').PageData} */
	export let data;
</script>

<div class="mt-5 pl-20">
	<span class="text-xl font-semibold dark:text-white"> Accounts </span>
</div>
<div class="grid grid-cols-4 gap-4 px-20 py-10">
	{#each data.item as item}
		<Card href="/accounts">
			<h1 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">
				Id: {item.id}
			</h1>
			<p class="mb-2 text-xl font-bold tracking-tight text-gray-900 dark:text-white">
				Owner: {item.owner}
			</p>
			<p class="font-normal text-gray-700 dark:text-gray-400 leading-tight">
				Currency: {item.currency}
			</p>
		</Card>
	{/each}
</div>
