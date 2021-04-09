#include "Main.h"
#include "Port.h"
#include "Sch51.h"

// ------ Public variable definitions ------------------------------

// The array of tasks
sTask SCH_tasks_G[SCH_MAX_TASKS];

tByte Error_code_G = 0;

// ------ Private function prototypes ------------------------------

static void SCH_Go_To_Sleep(void);

// ------ Private variables ----------------------------------------

// Keeps track of time since last error was recorded (see below)
static tWord Error_tick_count_G;

// The code of the last error (reset after ~1 minute)
static tByte Last_error_code_G;


/*------------------------------------------------------------------*-

-*------------------------------------------------------------------*/
void SCH_Dispatch_Tasks(void) 
   {
   tByte Index;

   // Dispatches (runs) the next task (if one is ready)
   for (Index = 0; Index < SCH_MAX_TASKS; Index++)
      {
      if (SCH_tasks_G[Index].RunMe > 0) 
         {
         (*SCH_tasks_G[Index].pTask)();  // Run the task

         SCH_tasks_G[Index].RunMe -= 1;   // Reset / reduce RunMe flag

         // Periodic tasks will automatically run again
         // - if this is a 'one shot' task, remove it from the array
         if (SCH_tasks_G[Index].Period == 0)
            {
            SCH_Delete_Task(Index);
            }
         }
      }

   // Report system status
   SCH_Report_Status();  

   // The scheduler enters idle mode at this point 
   SCH_Go_To_Sleep();          
   }

/*------------------------------------------------------------------*-

-*------------------------------------------------------------------*/
tByte SCH_Add_Task(void (code * pFunction)(), 
                   const tWord DELAY, 
                   const tWord PERIOD)    
   {
   tByte Index = 0;
   
   // First find a gap in the array (if there is one)
   while ((SCH_tasks_G[Index].pTask != 0) && (Index < SCH_MAX_TASKS))
      {
      Index++;
      } 
   
   // Have we reached the end of the list?   
   if (Index == SCH_MAX_TASKS)
      {
      // Task list is full
      //
      // Set the global error variable
      Error_code_G = ERROR_SCH_TOO_MANY_TASKS;

      // Also return an error code
      return SCH_MAX_TASKS;  
      }
      
   // If we're here, there is a space in the task array
   SCH_tasks_G[Index].pTask  = pFunction;
     
   SCH_tasks_G[Index].Delay  = DELAY;
   SCH_tasks_G[Index].Period = PERIOD;

   SCH_tasks_G[Index].RunMe  = 0;

   return Index; // return position of task (to allow later deletion)
   }
/*------------------------------------------------------------------*-
-*------------------------------------------------------------------*/
bit SCH_Delete_Task(const tByte TASK_INDEX) 
   {
   bit Return_code;

   if (SCH_tasks_G[TASK_INDEX].pTask == 0)
      {
      // No task at this location...
      //
      // Set the global error variable
      Error_code_G = ERROR_SCH_CANNOT_DELETE_TASK;

      // ...also return an error code
      Return_code = RETURN_ERROR;
      }
   else
      {
      Return_code = RETURN_NORMAL;
      }      
   
   SCH_tasks_G[TASK_INDEX].pTask   = 0x0000;
   SCH_tasks_G[TASK_INDEX].Delay   = 0;
   SCH_tasks_G[TASK_INDEX].Period  = 0;

   SCH_tasks_G[TASK_INDEX].RunMe   = 0;

   return Return_code;       // return status
   }

/*------------------------------------------------------------------*-
-*------------------------------------------------------------------*/
void SCH_Report_Status(void)
   {
#ifdef SCH_REPORT_ERRORS
   // ONLY APPLIES IF WE ARE REPORTING ERRORS
   // Check for a new error code
   if (Error_code_G != Last_error_code_G)
      {
      // Negative logic on LEDs assumed
      Error_port = 255 - Error_code_G;
      
      Last_error_code_G = Error_code_G;

      if (Error_code_G != 0)
         {
         Error_tick_count_G = 60000;
         }
      else
         {
         Error_tick_count_G = 0;
         }
      }
   else
      {
      if (Error_tick_count_G != 0)
         {
         if (--Error_tick_count_G == 0)
            {
            Error_code_G = 0; // Reset error code
            }
         }
      }
#endif   
   }

/*------------------------------------------------------------------*-
-*------------------------------------------------------------------*/
void SCH_Go_To_Sleep()
   {
   PCON |= 0x01;    // Enter idle mode (generic 8051 version)

   // Entering idle mode requires TWO consecutive instructions 
   // on 80c515 / 80c505 - to avoid accidental triggering
   //PCON |= 0x01;    // Enter idle mode (#1)
   //PCON |= 0x20;    // Enter idle mode (#2)
   }

/*------------------------------------------------------------------*-
  ---- END OF FILE -------------------------------------------------
-*------------------------------------------------------------------*/
