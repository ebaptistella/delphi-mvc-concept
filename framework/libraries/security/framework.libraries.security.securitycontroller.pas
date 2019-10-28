unit Framework.Libraries.Security.SecurityController;

interface


type
  ISecurityController = interface(IInvokable)
    ['{D5E0F8B0-236C-4085-9420-6A5164A946E8}']

    function isAllowed(const AController: TObject; const AMethod: Pointer): Boolean;
  end;

implementation

end.
