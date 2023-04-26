# create-svelte

Everything you need to build a Svelte project, powered by [`create-svelte`](https://github.com/sveltejs/kit/tree/master/packages/create-svelte).

## Creating a project

If you're seeing this, you've probably already done this step. Congrats!

```bash
# create a new project in frontend
npm create svelte@latest frontend
cd frontend
npm install
```

Install all necessary dependencies

```bash
# install tailwindcss
npx svelte-add@latest tailwindcss
# if previous command outputs error related to .npm-global install tailwindcss globally first
npm install -g tailwindcss
npm i
# instal Flowbite, Flowbite-Svelte, and other dependencies
npm i -D flowbite flowbite-svelte classnames @popperjs/core
```

## Developing

Once you've created a project and installed dependencies with `npm install` (or `pnpm install` or `yarn`), start a development server:

```bash
npm run dev

# or start the server and open the app in a new browser tab
npm run dev -- --open
```

## Building

To create a production version of your app:

```bash
npm run build
```

You can preview the production build with `npm run preview`.

> To deploy your app, you may need to install an [adapter](https://kit.svelte.dev/docs/adapters) for your target environment.
