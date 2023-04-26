<script lang="ts">

	import '../app.postcss';
	import { page } from '$app/stores';
	import { onMount } from 'svelte';
	import { goto } from '$app/navigation';
	import {
		Navbar,
		NavBrand,
		NavLi,
		NavUl,
		NavHamburger,
		Sidebar,
		SidebarGroup,
		SidebarBrand,
		SidebarCta,
		SidebarDropdownItem,
		SidebarItem,
		SidebarWrapper,
		SidebarDropdownWrapper,
		Drawer,
		CloseButton,
		DarkMode
	} from 'flowbite-svelte';
	import { sineIn } from 'svelte/easing';
	import { Home, User } from 'svelte-heros-v2';

	let drawerHidden: boolean = true;
	const toggleDrawer = () => {
		drawerHidden = !drawerHidden;
	};
	let divClass = 'w-full md:block md:w-auto';
	let ulClass = 'flex flex-col p-4 mt-4 md:flex-row md:space-x-8 md:mt-0 md:text-lg md:font-medium';

	let backdrop: boolean = false;
	let activateClickOutside = true;
	let breakPoint: number = 1024;
	let width: number;
	let transitionParams = {
		x: -320,
		duration: 200,
		easing: sineIn
	};

	activateClickOutside = true;

	const toggleSide = () => {
		drawerHidden = !drawerHidden;
	};
	$: activeUrl = $page.url.pathname;
	let spanClass = 'pl-2 self-center text-md text-gray-900 whitespace-nowrap dark:text-white';
</script>

<svelte:window bind:innerWidth={width} />

<Navbar let:hidden let:toggle>
	<NavHamburger on:click={toggleDrawer} btnClass="ml-3" />
	<NavBrand href="/" class="lg">
		<span class="text-xl font-semibold dark:text-white pl-24"> Cloud Computing </span>
	</NavBrand>
	<NavHamburger on:click={toggle} />
	<NavUl {hidden} {divClass} {ulClass} class="items-center">
		<NavLi href="https://github.com/pfcouto/cc-terraform-final">GitHub</NavLi>
		<DarkMode />
	</NavUl>
</Navbar>

<Drawer transitionType="fly" {transitionParams} bind:hidden={drawerHidden} id="sidebar2">
	<div class="flex items-center">
		<h5
			id="drawer-navigation-label-3"
			class="text-base font-semibold text-gray-500 uppercase dark:text-gray-400"
		>
			Menu
		</h5>
		<CloseButton on:click={() => (drawerHidden = true)} class="mb-4 dark:text-white" />
	</div>
	<Sidebar>
		<SidebarWrapper divClass="overflow-y-auto py-4 px-3 rounded dark:bg-gray-800">
			<SidebarGroup>
				<SidebarItem label="Home" href="/" on:click={toggleSide}>
					<svelte:fragment slot="icon">
						<Home />
					</svelte:fragment>
				</SidebarItem>

				<SidebarItem label="Get Accounts" href="/accounts" on:click={toggleSide}>
					<svelte:fragment slot="icon">
						<User />
					</svelte:fragment>
				</SidebarItem>

				<SidebarItem label="Post Account" href="/createAccount" on:click={toggleSide}>
					<svelte:fragment slot="icon">
						<User />
					</svelte:fragment>
				</SidebarItem>
			</SidebarGroup>
		</SidebarWrapper>
	</Sidebar>
</Drawer>

<div class="flex px-4 mx-auto w-full">
	<main class="w-full mx-auto">
		<slot />
	</main>
</div>
