/** @type {import('./$types').PageLoad} */
export async function load({ fetch, params }) {
	const res = await fetch(
		`${import.meta.env.VITE_Golang_API_URL || 'http://localhost:8080'}/accounts`
	);
	const item = await res.json();

	// console.log(item);

	return { item };
}
