class LightspeedFilter < ResultFilter      
  
  def on_result_executing(context)
    # put before result filtering code here
  end
  
  def on_result_executed(context)
    context.controller.uow_scope.dispose
  end
end