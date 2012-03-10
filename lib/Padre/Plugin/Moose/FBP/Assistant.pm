package Padre::Plugin::Moose::FBP::Assistant;

## no critic

# This module was generated by Padre::Plugin::FormBuilder::Perl.
# To change this module edit the original .fbp file and regenerate.
# DO NOT MODIFY THIS FILE BY HAND!

use 5.008005;
use utf8;
use strict;
use warnings;
use Padre::Wx 'Grid';
use Padre::Wx::Role::Main ();
use Padre::Wx::Editor     ();

our $VERSION = '0.19';
our @ISA     = qw{
	Padre::Wx::Role::Main
	Wx::Dialog
};

sub new {
	my $class  = shift;
	my $parent = shift;

	my $self = $class->SUPER::new(
		$parent,
		-1,
		Wx::gettext("Moose Assistant"),
		Wx::DefaultPosition,
		[ 750, 480 ],
		Wx::DEFAULT_DIALOG_STYLE | Wx::RESIZE_BORDER,
	);
	$self->SetSizeHints( [ 750, 480 ], Wx::DefaultSize );
	$self->SetMinSize( [ 750, 480 ] );

	my $m_staticText2 = Wx::StaticText->new(
		$self,
		-1,
		Wx::gettext("Object Tree"),
	);
	$m_staticText2->SetFont( Wx::Font->new( Wx::NORMAL_FONT->GetPointSize, 70, 90, 92, 0, "" ) );

	$self->{tree} = Wx::TreeCtrl->new(
		$self,
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::TR_DEFAULT_STYLE | Wx::SIMPLE_BORDER,
	);

	Wx::Event::EVT_KEY_UP(
		$self->{tree},
		sub {
			$self->on_tree_key_up( $_[1] );
		},
	);

	Wx::Event::EVT_TREE_ITEM_MENU(
		$self,
		$self->{tree},
		sub {
			shift->on_tree_item_menu(@_);
		},
	);

	Wx::Event::EVT_TREE_SEL_CHANGED(
		$self,
		$self->{tree},
		sub {
			shift->on_tree_selection_change(@_);
		},
	);

	my $m_staticText3 = Wx::StaticText->new(
		$self,
		-1,
		Wx::gettext("Properties"),
	);
	$m_staticText3->SetFont( Wx::Font->new( Wx::NORMAL_FONT->GetPointSize, 70, 90, 92, 0, "" ) );

	$self->{inspector} = Wx::Grid->new(
		$self,
		-1,
		Wx::DefaultPosition,
		[ -1, 150 ],
		Wx::SIMPLE_BORDER,
	);
	$self->{inspector}->CreateGrid( 20, 2 );
	$self->{inspector}->EnableEditing(1);
	$self->{inspector}->EnableGridLines(1);
	$self->{inspector}->EnableDragGridSize(0);
	$self->{inspector}->SetMargins( 0, 0 );
	$self->{inspector}->SetColSize( 0, 140 );
	$self->{inspector}->SetColSize( 1, 140 );
	$self->{inspector}->EnableDragColMove(0);
	$self->{inspector}->EnableDragColSize(1);
	$self->{inspector}->SetColLabelSize(0);
	$self->{inspector}->SetColLabelAlignment( Wx::ALIGN_CENTRE, Wx::ALIGN_CENTRE );
	$self->{inspector}->EnableDragRowSize(1);
	$self->{inspector}->SetRowLabelAlignment( Wx::ALIGN_CENTRE, Wx::ALIGN_CENTRE );
	$self->{inspector}->SetDefaultCellAlignment( Wx::ALIGN_LEFT, Wx::ALIGN_TOP );
	$self->{inspector}->SetMinSize( [ -1, 150 ] );

	Wx::Event::EVT_GRID_CELL_CHANGE(
		$self->{inspector},
		sub {
			$self->on_grid_cell_change( $_[1] );
		},
	);

	$self->{help} = Wx::TextCtrl->new(
		$self,
		-1,
		"",
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::TE_MULTILINE | Wx::TE_NO_VSCROLL | Wx::TE_READONLY | Wx::NO_BORDER,
	);
	$self->{help}->SetMinSize( [ -1, 100 ] );
	$self->{help}->SetForegroundColour( Wx::SystemSettings::GetColour(Wx::SYS_COLOUR_INFOBK) );
	$self->{help}->SetBackgroundColour( Wx::SystemSettings::GetColour(Wx::SYS_COLOUR_INFOBK) );

	my $m_staticText4 = Wx::StaticText->new(
		$self,
		-1,
		Wx::gettext("Palette"),
	);
	$m_staticText4->SetFont( Wx::Font->new( Wx::NORMAL_FONT->GetPointSize, 70, 90, 92, 0, "" ) );

	$self->{palette} = Wx::Notebook->new(
		$self,
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	$self->{containers} = Wx::Panel->new(
		$self->{palette},
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::TAB_TRAVERSAL,
	);

	$self->{add_class_button} = Wx::Button->new(
		$self->{containers},
		-1,
		Wx::gettext("&Class"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	Wx::Event::EVT_BUTTON(
		$self,
		$self->{add_class_button},
		sub {
			shift->on_add_class_button(@_);
		},
	);

	$self->{add_role_button} = Wx::Button->new(
		$self->{containers},
		-1,
		Wx::gettext("&Role"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	Wx::Event::EVT_BUTTON(
		$self,
		$self->{add_role_button},
		sub {
			shift->on_add_role_button(@_);
		},
	);

	$self->{members} = Wx::Panel->new(
		$self->{palette},
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::TAB_TRAVERSAL,
	);

	$self->{add_attribute_button} = Wx::Button->new(
		$self->{members},
		-1,
		Wx::gettext("&Attribute"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	Wx::Event::EVT_BUTTON(
		$self,
		$self->{add_attribute_button},
		sub {
			shift->on_add_attribute_button(@_);
		},
	);

	$self->{add_method_button} = Wx::Button->new(
		$self->{members},
		-1,
		Wx::gettext("&Method"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	Wx::Event::EVT_BUTTON(
		$self,
		$self->{add_method_button},
		sub {
			shift->on_add_method_button(@_);
		},
	);

	$self->{add_subtype_button} = Wx::Button->new(
		$self->{members},
		-1,
		Wx::gettext("&Subtype"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	Wx::Event::EVT_BUTTON(
		$self,
		$self->{add_subtype_button},
		sub {
			shift->on_add_subtype_button(@_);
		},
	);

	$self->{add_constructor_button} = Wx::Button->new(
		$self->{members},
		-1,
		Wx::gettext("&Constructor"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	Wx::Event::EVT_BUTTON(
		$self,
		$self->{add_constructor_button},
		sub {
			shift->on_add_constructor_button(@_);
		},
	);

	$self->{add_destructor_button} = Wx::Button->new(
		$self->{members},
		-1,
		Wx::gettext("&Destructor"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	Wx::Event::EVT_BUTTON(
		$self,
		$self->{add_destructor_button},
		sub {
			shift->on_add_destructor_button(@_);
		},
	);

	$self->{online_refs} = Wx::Panel->new(
		$self->{palette},
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::TAB_TRAVERSAL,
	);

	$self->{moose_manual_hyperlink} = Wx::HyperlinkCtrl->new(
		$self->{online_refs},
		-1,
		Wx::gettext("Moose Manual"),
		"https://metacpan.org/module/Moose::Manual",
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::HL_DEFAULT_STYLE,
	);

	$self->{moose_cookbook_hyperlink} = Wx::HyperlinkCtrl->new(
		$self->{online_refs},
		-1,
		Wx::gettext("How to Cook a Moose?"),
		"https://metacpan.org/module/Moose::Cookbook",
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::HL_DEFAULT_STYLE,
	);

	$self->{moose_website_hyperlink} = Wx::HyperlinkCtrl->new(
		$self->{online_refs},
		-1,
		Wx::gettext("Moose Website"),
		"http://moose.iinteractive.com/",
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::HL_DEFAULT_STYLE,
	);

	my $m_staticText5 = Wx::StaticText->new(
		$self,
		-1,
		Wx::gettext("Preview"),
	);
	$m_staticText5->SetFont( Wx::Font->new( Wx::NORMAL_FONT->GetPointSize, 70, 90, 92, 0, "" ) );

	$self->{preview} = Padre::Wx::Editor->new(
		$self,
		-1,
	);

	my $m_staticline2 = Wx::StaticLine->new(
		$self,
		-1,
		Wx::DefaultPosition,
		Wx::DefaultSize,
		Wx::LI_HORIZONTAL,
	);

	$self->{generate_code_button} = Wx::Button->new(
		$self,
		-1,
		Wx::gettext("&Generate"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	Wx::Event::EVT_BUTTON(
		$self,
		$self->{generate_code_button},
		sub {
			shift->on_generate_code_button_clicked(@_);
		},
	);

	$self->{reset_button} = Wx::Button->new(
		$self,
		-1,
		Wx::gettext("Reset"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	Wx::Event::EVT_BUTTON(
		$self,
		$self->{reset_button},
		sub {
			shift->on_reset_button_clicked(@_);
		},
	);

	$self->{preferences_button} = Wx::Button->new(
		$self,
		-1,
		Wx::gettext("&Preferences"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	Wx::Event::EVT_BUTTON(
		$self,
		$self->{preferences_button},
		sub {
			shift->on_preferences_button_clicked(@_);
		},
	);

	$self->{close_button} = Wx::Button->new(
		$self,
		Wx::ID_CANCEL,
		Wx::gettext("Close"),
		Wx::DefaultPosition,
		Wx::DefaultSize,
	);

	my $left_sizer = Wx::BoxSizer->new(Wx::VERTICAL);
	$left_sizer->Add( $m_staticText2,     0, Wx::EXPAND | Wx::LEFT | Wx::RIGHT | Wx::TOP,    5 );
	$left_sizer->Add( $self->{tree},      1, Wx::ALL | Wx::EXPAND,                           5 );
	$left_sizer->Add( $m_staticText3,     0, Wx::EXPAND | Wx::LEFT | Wx::RIGHT | Wx::TOP,    5 );
	$left_sizer->Add( $self->{inspector}, 0, Wx::ALL | Wx::EXPAND,                           5 );
	$left_sizer->Add( $self->{help},      0, Wx::BOTTOM | Wx::EXPAND | Wx::LEFT | Wx::RIGHT, 5 );

	my $container_sizer = Wx::BoxSizer->new(Wx::HORIZONTAL);
	$container_sizer->Add( $self->{add_class_button}, 0, Wx::ALIGN_CENTER_HORIZONTAL | Wx::ALL, 2 );
	$container_sizer->Add( $self->{add_role_button}, 0, Wx::ALL, 2 );

	$self->{containers}->SetSizerAndFit($container_sizer);
	$self->{containers}->Layout;

	my $members_sizer = Wx::BoxSizer->new(Wx::HORIZONTAL);
	$members_sizer->Add( $self->{add_attribute_button},   0, Wx::ALL, 2 );
	$members_sizer->Add( $self->{add_method_button},      0, Wx::ALL, 2 );
	$members_sizer->Add( $self->{add_subtype_button},     0, Wx::ALL, 2 );
	$members_sizer->Add( $self->{add_constructor_button}, 0, Wx::ALL, 2 );
	$members_sizer->Add( $self->{add_destructor_button},  0, Wx::ALL, 2 );

	$self->{members}->SetSizerAndFit($members_sizer);
	$self->{members}->Layout;

	my $online_refs_sizer = Wx::BoxSizer->new(Wx::HORIZONTAL);
	$online_refs_sizer->Add( $self->{moose_manual_hyperlink},   0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$online_refs_sizer->Add( $self->{moose_cookbook_hyperlink}, 0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );
	$online_refs_sizer->Add( $self->{moose_website_hyperlink},  0, Wx::ALIGN_CENTER_VERTICAL | Wx::ALL, 5 );

	$self->{online_refs}->SetSizerAndFit($online_refs_sizer);
	$self->{online_refs}->Layout;

	$self->{palette}->AddPage( $self->{containers},  Wx::gettext("Containers"),        1 );
	$self->{palette}->AddPage( $self->{members},     Wx::gettext("Members"),           0 );
	$self->{palette}->AddPage( $self->{online_refs}, Wx::gettext("Online References"), 0 );

	my $button_sizer = Wx::BoxSizer->new(Wx::HORIZONTAL);
	$button_sizer->Add( $self->{generate_code_button}, 0, Wx::ALIGN_BOTTOM | Wx::ALL,                          5 );
	$button_sizer->Add( $self->{reset_button},         0, Wx::ALIGN_BOTTOM | Wx::BOTTOM | Wx::RIGHT | Wx::TOP, 5 );
	$button_sizer->Add( $self->{preferences_button},   0, Wx::ALL,                                             5 );
	$button_sizer->Add( 0, 0, 1, Wx::EXPAND, 5 );
	$button_sizer->Add( $self->{close_button}, 0, Wx::ALIGN_BOTTOM | Wx::ALL, 5 );

	my $right_sizer = Wx::BoxSizer->new(Wx::VERTICAL);
	$right_sizer->Add( $m_staticText4,   0, Wx::EXPAND | Wx::LEFT | Wx::RIGHT | Wx::TOP, 5 );
	$right_sizer->Add( $self->{palette}, 0, Wx::EXPAND | Wx::ALL,                        5 );
	$right_sizer->Add( $m_staticText5,   0, Wx::EXPAND | Wx::LEFT | Wx::RIGHT | Wx::TOP, 5 );
	$right_sizer->Add( $self->{preview}, 1, Wx::ALL | Wx::EXPAND,                        5 );
	$right_sizer->Add( $m_staticline2,   0, Wx::EXPAND | Wx::LEFT | Wx::RIGHT,           5 );
	$right_sizer->Add( $button_sizer,    0, Wx::EXPAND,                                  5 );

	my $top_sizer = Wx::BoxSizer->new(Wx::HORIZONTAL);
	$top_sizer->Add( $left_sizer,  0, Wx::EXPAND, 5 );
	$top_sizer->Add( $right_sizer, 1, Wx::EXPAND, 5 );

	my $main_sizer = Wx::BoxSizer->new(Wx::VERTICAL);
	$main_sizer->Add( $top_sizer, 1, Wx::EXPAND, 5 );

	$self->SetSizer($main_sizer);
	$self->Layout;

	return $self;
}

sub on_tree_key_up {
	$_[0]->main->error('Handler method on_tree_key_up for event tree.OnKeyUp not implemented');
}

sub on_tree_item_menu {
	$_[0]->main->error('Handler method on_tree_item_menu for event tree.OnTreeItemMenu not implemented');
}

sub on_tree_selection_change {
	$_[0]->main->error('Handler method on_tree_selection_change for event tree.OnTreeSelChanged not implemented');
}

sub on_grid_cell_change {
	$_[0]->main->error('Handler method on_grid_cell_change for event inspector.OnGridCellChange not implemented');
}

sub on_add_class_button {
	$_[0]->main->error('Handler method on_add_class_button for event add_class_button.OnButtonClick not implemented');
}

sub on_add_role_button {
	$_[0]->main->error('Handler method on_add_role_button for event add_role_button.OnButtonClick not implemented');
}

sub on_add_attribute_button {
	$_[0]->main->error(
		'Handler method on_add_attribute_button for event add_attribute_button.OnButtonClick not implemented');
}

sub on_add_method_button {
	$_[0]->main->error('Handler method on_add_method_button for event add_method_button.OnButtonClick not implemented');
}

sub on_add_subtype_button {
	$_[0]->main->error(
		'Handler method on_add_subtype_button for event add_subtype_button.OnButtonClick not implemented');
}

sub on_add_constructor_button {
	$_[0]->main->error(
		'Handler method on_add_constructor_button for event add_constructor_button.OnButtonClick not implemented');
}

sub on_add_destructor_button {
	$_[0]->main->error(
		'Handler method on_add_destructor_button for event add_destructor_button.OnButtonClick not implemented');
}

sub on_generate_code_button_clicked {
	$_[0]->main->error(
		'Handler method on_generate_code_button_clicked for event generate_code_button.OnButtonClick not implemented');
}

sub on_reset_button_clicked {
	$_[0]->main->error('Handler method on_reset_button_clicked for event reset_button.OnButtonClick not implemented');
}

sub on_preferences_button_clicked {
	$_[0]->main->error(
		'Handler method on_preferences_button_clicked for event preferences_button.OnButtonClick not implemented');
}

1;

# Copyright 2008-2012 The Padre development team as listed in Padre.pm.
# LICENSE
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl 5 itself.
