#ifndef OBJWINDOW_H
#define OBJWINDOW_H

#include <windows.h>
#include <commctrl.h>
#undef GetObject

#include "Dark/utils.h"
#include "DarkLib/DarkDB.h"

#include "WindowBase.h"
#include "PropertyTree.h"

class ObjTreeMain;

class ObjWindow : public Window
{
	ObjTreeMain& m_parent;
	Dark::DarkObject* m_object;

	enum 
	{
		kPropPage = 0,
		kMetapropPage,
		kLinkPage,
		kStimPage,
		kReceptronPage,
		kLastPage
	};

	Window* m_pages[5];
	Window m_tabs;
	PropertyTree m_props;
	Window m_metaprops, m_links, m_stims, m_receptrons;

	struct LinkEditor
	{
		PropertyTree* editor;
		const Window& listwin;
		sint32	linkid;
		std::string* data;
		LinkEditor(sint32,const Window&);
		//LinkEditor(sint32,const Window&,const Window&);
		~LinkEditor();
		void Update();
	};

	std::map<sint32,LinkEditor*> m_editors;

public:
	~ObjWindow();
	ObjWindow(Dark::DarkObject* obj, ObjTreeMain& parent, HINSTANCE inst);

private:
	ObjWindow(const ObjWindow&);
	ObjWindow& operator=(const ObjWindow&);

public:
	static BOOL RegisterClass(HINSTANCE inst);
	BOOL Create(HINSTANCE inst);

	void AdjustLayout();

	PropertyTree* GetPropertyEditor();
	PropertyTree* GetMetapropertyEditor(sint32 id);
	PropertyTree* GetLinkEditor(sint32 id);
	PropertyTree* GetStimulusEditor(sint32 id);
	PropertyTree* GetReceptronEditor(sint32 id);
	PropertyTree* FindEditor(sint32 id);
	PropertyTree* OpenEditor(sint32 id, const Window& listwin, LPCTSTR title);
	PropertyTree* CreateEditor(sint32 id, const Window& listwin, LPCTSTR title);
	void EraseEditor(sint32 id);
	void CloseEditor(sint32 id);
	void ToggleEditors(int param);
	bool EditListItem(HWND listwin, int rownum);
	bool EditMetapropertyItem(sint32 id);
	bool EditLinkItem(sint32 id);
	bool EditStimItem(sint32 id);
	bool EditReceptronItem(sint32 id);

	void UpdateObject();
	Dark::DarkProp* AddProperty(const std::string& propname);
	bool AddProperty(const std::string& propname, Dark::DarkProp* prop);
	Dark::DarkProp* RemoveProperty(const std::string& propname);
	bool AddLink(Dark::DarkLink* link);
	bool RemoveLink(Dark::DarkLink* link);
	Dark::DarkLink* CreateLink(sint32 id, uint32 flavor);
	Dark::DarkLinkMetaProp* CreateMetaproperty(sint32 id, sint32 priority);
	Dark::DarkLinkStimulus* CreateStimulus(sint32 id, sint32 type);
	Dark::DarkLinkReceptron* CreateReceptron(sint32 id);

	void DoAddProperty();
	void DoRemoveProperty();
	void DoAddMetaproperty();
	void DoRemoveMetaproperty();
	void DoAddLink();
	void DoRemoveLink();
	void DoAddStimulus();
	void DoRemoveStimulus();
	void DoAddReceptron();
	void DoRemoveReceptron();

private:
	static LRESULT CALLBACK WindowProc(HWND, UINT, WPARAM, LPARAM);

	static const TCHAR* szClassName;

	BOOL CreatePropertyPage(HINSTANCE inst);
	BOOL InitPropertyPage();
	BOOL CreateMetapropertyPage(HINSTANCE inst);
	BOOL InitMetapropertyPage();
	BOOL CreateLinkPage(HINSTANCE inst);
	BOOL InitLinkPage();
	BOOL CreateStimPage(HINSTANCE inst);
	BOOL InitStimPage();
	BOOL CreateReceptronPage(HINSTANCE inst);
	BOOL InitReceptronPage();

	void DisplayListItem(HWND listwin, LVITEM& item);
	void DisplayMetaproperty(LVITEM& item);
	void DisplayLink(LVITEM& item);
	void DisplayStimulus(LVITEM& item);
	void DisplayReceptron(LVITEM& item);

	void InitStimulusEditorProps(PropertyTree* editor, Dark::DarkLinkStimulus* stim);
	void BeginStimSourceEdit(LinkEditor* info);
	void EndStimSourceEdit(LinkEditor* info);

	void InitReceptronEditorProps(PropertyTree* editor, Dark::DarkLinkReceptron* stim);
	void BeginReactionEffectEdit(LinkEditor* info);
	void EndReactionEffectEdit(LinkEditor* info);

	void HandlePropertyChanging(const PTNINFO* propinfo);
	void HandlePropertyChanged(const PTNINFO* propinfo);
	void HandlePropertyChangeCanceled(const PTNINFO* propinfo);
};

#endif // OBJWINDOW_H
