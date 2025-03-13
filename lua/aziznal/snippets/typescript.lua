local luasnip = require("luasnip")
luasnip.setup()

local extras = require("luasnip.extras")
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
local rep = extras.rep

-- [[ See docs @https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md ]]

local react_snippets = {
	s(
		"component",
		fmt(
			[[
type `1~Props = {};

export const `2~ = (props: `3~Props) => {
	return (
		<div>
			<h1>Hello World!</h1>
		</div>
	)
}
			]],
			{
				i(1, "ComponentName"),
				rep(1),
				rep(1),
			},
			{
				delimiters = "`~",
			},
			{
				delimiters = "`~",
			}
		)
	),
	s(
		"component-function",
		fmt(
			[[
type `2~Props = {};

export function `1~(props: `3~Props) {
	return (
		<div>
			<h1>Hello World!</h1>
		</div>
	)
}
					  ]],
			{
				i(1, "ComponentName"),
				rep(1),
				rep(1),
			},
			{
				delimiters = "`~",
			},
			{
				delimiters = "`~",
			}
		)
	),

	s(
		"component-fc",
		fmt(
			[[

const `1~: React.FC<{ name: string }> = (props) => {
  return <div>
    Hello, {props.name}
  </div>
}
					  ]],
			{
				i(1, "Example"),
			},
			{
				delimiters = "`~",
			}
		)
	),

	s(
		"component-fc-cn",
		fmt(
			[[
import { cn } from '@/lib/utils';

const `1~: React.FC<{ className?: string }> = (props) => {
  return <div className={cn(props.className)}>
    Hello World!
  </div>
}
					  ]],
			{
				i(1, "Example"),
			},
			{
				delimiters = "`~",
			}
		)
	),

	s(
		"component-forward-ref",
		fmt(
			[[
import { forwardRef } from "react";

type `1~Props = React.HTMLAttributes<HTMLElement> & {};

const `2~ = forwardRef<HTMLElement, `3~Props>(
 ({ ...props }, ref) => {
	return (
	 <div
		 ref={ref}
		 {...props}
	 >
		 <h1>Hello World!</h1>
	 </div>
	);
 },
);

`4~.displayName = "`5~";

export `6~;
]],
			{
				i(1, "ComponentName"),
				rep(1),
				rep(1),
				rep(1),
				rep(1),
				rep(1),
			},
			{
				delimiters = "`~",
			}
		)
	),

	s(
		"react-context",
		fmt(
			[[
import { PropsWithChildren, createContext, useContext } from "react";

type `1~ContextType = {};

const `2~Context = createContext<`3~ContextType>({} as `4~ContextType);

export const use`5~Context = () => useContext(`6~Context);

export const `7~ContextProvider = ({ children }: PropsWithChildren) => {
  return (
    <`8~Context.Provider
      value={{}}
    >
      {children}
    </`9~Context.Provider>
  );
};
]],
			{
				i(1, "Example"),
				rep(1),
				rep(1),
				rep(1),
				rep(1),
				rep(1),
				rep(1),
				rep(1),
				rep(1),
			},
			{
				delimiters = "`~",
			}
		)
	),
}

local nextjs_snippets = {

	s(
		"next-page",
		fmt(
			[[
export default function Page() {
  return <div>Page</div>;
}
]],
			{},
			{
				delimiters = "`~",
			}
		)
	),

	s(
		"next-layout",
		fmt(
			[[
export default function Layout({ children }: { children: React.ReactNode }) {
  return <>{children}</>;
}
]],
			{},
			{
				delimiters = "`~",
			}
		)
	),
}

local shadcn_snippets = {

	s(
		"form-item",
		fmt(
			[[
<FormField
	control={form.control}
	name="email"
	render={({ field }) => (
		<FormItem>
			<FormLabel>Email</FormLabel>

			<FormControl>
				<Input type="email" {...field} />
			</FormControl>

			<FormMessage />
		</FormItem>
	)}
/>
]],
			{},
			{
				delimiters = "`~",
			}
		)
	),

	s(
		"shadcn-dialog-imports",
		fmt(
			[[
import {
	Dialog,
	DialogContent,
	DialogDescription,
	DialogHeader,
	DialogTitle,
	DialogTrigger,
} from "@/components/ui/dialog"
]],
			{},
			{
				delimiters = "`~",
			}
		)
	),

	s(
		"shadcn-dialog",
		fmt(
			[[
<Dialog>
	<DialogTrigger>Open</DialogTrigger>
	<DialogContent>
		<DialogHeader>
			<DialogTitle>Are you absolutely sure?</DialogTitle>
			<DialogDescription>
	This action cannot be undone. This will permanently delete your account
	and remove your data from our servers.
			</DialogDescription>
		</DialogHeader>
	</DialogContent>
</Dialog>
]],
			{},
			{
				delimiters = "`~",
			}
		)
	),

	s(
		"shadcn-dropdownmenu-imports",
		fmt(
			[[
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuItem,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
					]],
			{},
			{
				delimiters = "`~",
			}
		)
	),

	s(
		"shadcn-dropdownmenu",
		fmt(
			[[
<DropdownMenu>
	<DropdownMenuTrigger>Open</DropdownMenuTrigger>
	<DropdownMenuContent>
		<DropdownMenuItem>Item 1</DropdownMenuItem>
		<DropdownMenuItem>Item 2</DropdownMenuItem>
	</DropdownMenuContent>
</DropdownMenu>
]],
			{},
			{
				delimiters = "`~",
			}
		)
	),

	s(
		"shadcn-accordion",
		fmt(
			[[
<Accordion type="single" collapsible>
  <AccordionItem value="foo">
    <AccordionTrigger>Open</AccordionTrigger>
    <AccordionContent>Accordion</AccordionContent>
  </AccordionItem>
</Accordion>
]],
			{},
			{
				delimiters = "`~",
			}
		)
	),

	s(
		"shadcn-accordion-imports",
		fmt(
			[[
import { cn } from "@/lib/common/utils";
import {
  Accordion,
  AccordionItem,
  AccordionTrigger,
  AccordionContent,
} from "@/components/ui/accordion";
]],
			{},
			{
				delimiters = "`~",
			}
		)
	),
}

local dnd_snippets = {

	s(
		"dnd-imports",
		fmt(
			[[
import { DndContext, DragEndEvent } from "@dnd-kit/core";
import { restrictToVerticalAxis } from "@dnd-kit/modifiers";
import {
  SortableContext,
  arrayMove,
  useSortable,
  verticalListSortingStrategy,
} from "@dnd-kit/sortable";
import { CSS } from "@dnd-kit/utilities";
]],
			{},
			{
				delimiters = "`~",
			}
		)
	),

	s(
		"dnd-context",
		fmt(
			[[
<DndContext onDragEnd={onDragEnd} modifiers={[restrictToVerticalAxis]}>
	<SortableContext items={items} strategy={verticalListSortingStrategy}>
		{items.map((item) => (
			<Item key={item.id} id={item.id} />
		))}
	</SortableContext>
</DndContext>
]],
			{},
			{
				delimiters = "`~",
			}
		)
	),

	s(
		"dnd-item",
		fmt(
			[[
const Item: React.FC<{ id: number }> = (props) => {
  const sortable = useSortable({ id: props.id });
  const sortableStyle = {
    transform: CSS.Translate.toString(sortable.transform),
    transition: sortable.transition,
  };

  return (
    <div
      style={sortableStyle}
      ref={sortable.setNodeRef}
      {...sortable.listeners}
      {...sortable.attributes}
    ></div>
  );
};
]],
			{},
			{
				delimiters = "`~",
			}
		)
	),

	s(
		"dnd-ondragend",
		fmt(
			[[
const onDragEnd = (event: DragEndEvent) => {
	const { active, over } = event;

	if (!over || active.id === over.id) return;

	const oldIndex = items.findIndex((cur) => cur.id === active.id);
	const newIndex = items.findIndex((cur) => cur.id === over.id);

	const updatedItems = arrayMove(items, oldIndex, newIndex);

	setItems(updatedItems);
};
]],
			{},
			{
				delimiters = "`~",
			}
		)
	),
}

local misc_snippets = {
	s(
		"zustand-store-local",
		fmt(
			[[
import { create } from 'zustand'
import { persist, createJSONStorage } from 'zustand/middleware'

type BearStore = {
  bears: number
  addABear: () => void
}

export const useBearStore = create<BearStore>()(
  persist(
    (set, get) => ({
      bears: 0,
      addABear: () => set({ bears: get().bears + 1 }),
    }),
    {
      name: 'food-storage', 
      storage: createJSONStorage(() => localStorage), 
    },
  ),
)

]],
			{},
			{
				delimiters = "`~",
			}
		)
	),

	s(
		"log-with-new-lines",
		fmt(
			[[
console.log("\n\n\n")
console.log()
console.log("\n\n\n")
]],
			{},
			{
				delimiters = "`~",
			}
		)
	),
}

luasnip.add_snippets("typescriptreact", react_snippets)
luasnip.add_snippets("typescriptreact", nextjs_snippets)
luasnip.add_snippets("typescriptreact", shadcn_snippets)
luasnip.add_snippets("typescriptreact", dnd_snippets)
luasnip.add_snippets("typescriptreact", misc_snippets)

luasnip.add_snippets("typescript", shadcn_snippets)
luasnip.add_snippets("typescript", misc_snippets)
